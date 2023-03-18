#!/bin/bash

set -e

rest=$@

IMAGE=your_image_name:latest

CONTAINER_ID=$(docker inspect --format="{{.Id}}" ${IMAGE} 2> /dev/null)
if [[ "${CONTAINER_ID}" ]]; then
    docker run --runtime=nvidia --shm-size=2g --gpus all --restart=always -p 9012:9012 -v `pwd`:/scratch --user $(id -u):$(id -g) --workdir=/scratch -e HOME=/scratch $IMAGE $@
else
    echo "Unknown container image: ${IMAGE}"
    exit 1
fi