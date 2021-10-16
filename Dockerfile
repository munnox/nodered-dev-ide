# https://hub.docker.com/r/nodered/node-red/
# https://github.com//node-red/node-red-docker

FROM nodered/node-red:2.0.6-14
ARG DOCKER_GRP=$(getent group docker | cut -d: -f3)

USER root
RUN addgroup --g ${DOCKER_GRP} docker
RUN addgroup node-red docker

RUN apk add --no-cache gcc python3-dev libffi-dev openssl-dev docker
# build-base linux-headers musl-dev

USER node-red

ENV PATH="/usr/src/node-red/.cargo/bin:/usr/src/node-red/.local/bin:${PATH}"

RUN curl https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init --output /tmp/rustup-init \
    && chmod +x /tmp/rustup-init \
    && /tmp/rustup-init -y

RUN pip3 install ansible

# COPY package.json /data/package.json
COPY settings.js /data/settings.js
# RUN mkdir -p /data/projects/.sshkeys/

# COPY ssh/known_hosts /usr/src/node-red/.ssh/known_hosts
# COPY ssh/id_rsa /usr/src/node-red/.ssh/id_rsa
# COPY ssh/id_rsa.pub /usr/src/node-red/.ssh/id_rsa.pub
# COPY ssh/id_rsa /data/projects/.sshkeys/admin_base
# COPY ssh/id_rsa.pub /data/projects/.sshkeys/admin_base.pub