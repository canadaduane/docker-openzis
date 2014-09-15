# OpenZIS in Docker

Get a quick Zone Integration Server (ZIS) server up and running in Docker. A ZIS is an information exchange server used by the School Interoperability Framework (SIF) standard.

## Building the Docker Image

First step is to download the OpenZIS source code in the same directory:

```
git submodule init
git submodule update
```

Next, build the image:

```
docker build -t openzis .
```

## Running the Container

Once your image is built, you can run it as a container:

```
docker run -d -p 80:80 openzis
```
