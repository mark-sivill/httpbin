FROM docker.io/chainguard/python:latest-dev AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/linky/venv/bin:$PATH"

WORKDIR /linky

RUN python -m venv /linky/venv

#
# choose whether to use pre-generated or current python library versions
#

# 1) use orginal generated requirements.txt created in March 2025
#COPY requirements.txt .
#RUN pip install --no-cache-dir -r requirements.txt

# 2) override pre-generated requirements.txt with newer library versions during build
RUN pip install flask six flasgger brotli decorator gunicorn gevent \
  && pip freeze > requirements.txt

# copy python source code
COPY httpbin ./httpbin/

FROM docker.io/chainguard/python:latest

# avoid well-known ports on 1024 or below, that require root user to listen on 
# the docker run command can map to another port if required
# for example
# docker run -p 80:9000 marksivill/httpbin 
EXPOSE 9000

WORKDIR /linky

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY httpbin ./httpbin/
COPY --from=builder /linky/venv /venv

ENTRYPOINT [ "python", "-m", "gunicorn", "--bind", "0.0.0.0:9000", "httpbin:app", "--worker-class", "gevent" ]

