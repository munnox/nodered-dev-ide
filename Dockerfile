# BAsic build of a Development NodeRED IDE for playing with things
# This is not meant to be the most secure but to have functionality
# but over time I would like to find ways to keep and improve the
# basic security while maintaining the functionality
# Author Robert Munnoch

# https://hub.docker.com/r/nodered/node-red/
# https://github.com//node-red/node-red-docker

FROM nodered/node-red:2.0.6-14
ARG DOCKER_GRP=$(getent group docker | cut -d: -f3)
ARG GIT_SERVER=github.com

USER root
# Add a docker group with the right Docker group ID to sync with the host.
RUN addgroup --g ${DOCKER_GRP} docker
RUN addgroup node-red docker

RUN apk add --no-cache gcc python3-dev libffi-dev openssl-dev docker
# build-base linux-headers musl-dev

USER node-red

ENV PATH="/usr/src/node-red/.cargo/bin:/usr/src/node-red/.local/bin:${PATH}"

# Add Rust to the container
RUN curl https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init --output /tmp/rustup-init \
    && chmod +x /tmp/rustup-init \
    && /tmp/rustup-init -y

# Add ansible to the container for play time
RUN pip3 install ansible

USER root
# Move the SSH keys in to the container
COPY ssh /usr/src/node-red/.ssh

# Get current server fingerprint
RUN ssh-keyscan ${GIT_SERVER} >> /usr/src/node-red/.ssh/fingerprintkey
RUN ssh-keygen -lf /usr/src/node-red/.ssh/fingerprintkey
RUN cat /usr/src/node-red/.ssh/fingerprintkey >> /usr/src/node-red/.ssh/known_hosts

# Correct permission on the copied folder
RUN chown node-red:node-red -R /usr/src/node-red/.ssh/ && chmod -R a-rw,u+r /usr/src/node-red/.ssh

# Move the server certificates in to the container
COPY certs /certs/
# Correct the permission for certs
RUN chown node-red:node-red -R /certs/ && chmod -R a-rw,u+r /certs/

USER node-red

RUN npm install @node-red-contrib-themes/dracula

# COPY package.json /data/package.json
COPY settings.js /data/settings.js
# RUN mkdir -p /data/projects/.sshkeys/

# ENTRYPOINT ["/bin/bash"]