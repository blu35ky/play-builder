ifndef DOCKER_IP
	DOCKER_IP=localhost
endif
export DOCKER_IP

ifndef TAG
        TAG=$(shell git rev-parse --short HEAD)
endif
export TAG

image:
	docker build -t brickx/play-builder:${TAG} .
	docker tag -f brickx/play-builder:${TAG} brickx/play-builder:latest

push: image
	docker push brickx/play-builder:${TAG}

all: image

_phony: all
