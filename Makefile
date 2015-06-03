ifndef DOCKER_IP
	DOCKER_IP=localhost
endif
export DOCKER_IP

ifndef TAG
        TAG=dev
endif
export TAG

image:
	docker build -t brickx/play-builder:${TAG} .
	docker tag -f brickx/play-builder:${TAG} brickx/play-builder:latest

all: image

_phony: all