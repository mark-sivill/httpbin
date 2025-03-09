# httpbin
A simple and hardened HTTP Request &amp; Response Service

## Background

This is a hardened docker container based on the orginal httpbin work done by Kenneth Reitz

* [httpbin in docker hub](https://hub.docker.com/r/kennethreitz/httpbin/)
* [httpbin in github](https://github.com/postmanlabs/httpbin/)
* [httpbin deployment](https://httpbin.org/)

The Python code is reworked to use [venv](https://docs.python.org/3/library/venv.html) as the virtual environment and leverages [Chainguard](http://chainguard.dev) secure docker images.

The build follows the [Chainguard Python recommendations](https://edu.chainguard.dev/chainguard/chainguard-images/getting-started/python/) which includes

* minimal software 
* multi-stage builds

 [Chainguard's Python docker images](https://hub.docker.com/r/chainguard/python) for both

* development `:lastest-dev`
* production `:latest`

## Running

### From Docker Hub

```
docker run -p 80:9000 marksivill/httpbin:latest
```

### From Github

Download source code from github, build, then run.

```
git clone https://github.com/mark-sivill/httpbin
cd httpbin
docker build --no-cache --tag local-httpbin:github-build .
docker run -p 80:9000 local-httpbin:github-build
```

## Testing

Any of the following commands will get responses from the httpbin application, when the docker container is running on the local machine.

```
curl http://127.0.0.1/uuid
```

```
curl http://127.0.0.1/anything
```

```
curl http://127.0.0.1/ip
```



