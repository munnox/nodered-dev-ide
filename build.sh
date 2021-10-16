#!/bin/bash

DOCKER_GRP=$(getent group docker | cut -d: -f3)

docker compose build --build-arg DOCKER_GRP=$DOCKER_GRP