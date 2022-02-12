#!/bin/bash

# Make/ensure directories for the support files
mkdir backup certs

# Make a selfsign certificate the subject line can be made more specific
# to use case.
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=GB/ST=/L=England/O=Local/CN=www.example.com" \
    -keyout certs/certs.key \
    -out certs/certs.cert
sudo chown $USER:1000 -R ./certs
sudo chmod -R ug+wr ./certs

# Need to get the Docker group for a the full IDE experience.
DOCKER_GRP=$(getent group docker | cut -d: -f3)

# Run the the build
docker-compose build --build-arg DOCKER_GRP=$DOCKER_GRP
# docker-compose build --no-cache --build-arg DOCKER_GRP=$DOCKER_GRP