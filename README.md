Play! builder
======================

## Usage

```
docker run -e IMAGE_NAME:"fooinc/app:version" -v /root/.ivy2:/root/.ivy2 -v $(pwd):/opt/app -v /var/run/docker.sock:/var/run/docker.sock brickx/play-builder:latest
```

## Details

### IMAGE_NAME
IMAGE_NAME specifies the name and tag of the image created by the builder, you can apply custom tags outside of the builder script if required.

### Ivy2 cache
Although not required, adding a valid ivy cache path speeds up builds significantly.

### App path
The builder requried a valid play application to be attached in /opt/app, the builder will fail if no app is present


## Hooks

### pre-dist
Before running the activator dist task the builder executes pre_dist.sh if present.
This allows any additional preparation to be done.
