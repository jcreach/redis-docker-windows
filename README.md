# redis-docker-windows

Redis image for Windows 

## Overview

Quick implementation of redis for docker windows. For more information see this link : [redis for Windows](https://github.com/tporadowski/redis).

## How to use

### Use pre-built docker image

You can find the pre-build docker image on [Docker Hub](https://hub.docker.com/r/jcreach/redis).

Pull it :

```powershell
docker pull jcreach/redis
```

Run it like that : 

```powershell
docker run --name my-redis -p 6379:6379 -d jcreach/redis:5.0.14.1-lts-nanoserver-1809
```

Or with a password :

```powershell
docker run --name my-redis -p 6379:6379 -d jcreach/redis:5.0.14.1-lts-nanoserver-1809 --requirepass MySuperPassword
```

### Build your own

```powershell
docker build --pull --rm -f "dockerfile" -t <imagee_name>:<tag> .
```
