# https://hub.docker.com/r/nodered/node-red/
# https://github.com//node-red/node-red-docker

FROM nodered/node-red:2.0.6-14

USER root

RUN apk add gcc python3-dev libffi-dev openssl-dev

# build-base linux-headers musl-dev

    # && pip install --no-cache-dir cryptography \
    # && rustup self uninstall -y

USER node-red

ENV PATH="/usr/src/node-red/.cargo/bin:/usr/src/node-red/.local/bin:${PATH}"

RUN curl https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init --output /tmp/rustup-init \
    && chmod +x /tmp/rustup-init \
    && /tmp/rustup-init -y

RUn pip3 install ansible

# COPY package.json /data/package.json
COPY settings.js /data/settings.js

# RUN mkdir -p /data/projects/.sshkeys/

# COPY ssh/known_hosts /usr/src/node-red/.ssh/known_hosts
# COPY ssh/id_rsa /usr/src/node-red/.ssh/id_rsa
# COPY ssh/id_rsa.pub /usr/src/node-red/.ssh/id_rsa.pub
# COPY ssh/id_rsa /data/projects/.sshkeys/admin_base
# COPY ssh/id_rsa.pub /data/projects/.sshkeys/admin_base.pub