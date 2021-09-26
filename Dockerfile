# https://hub.docker.com/r/nodered/node-red/
# https://github.com//node-red/node-red-docker

FROM nodered/node-red:2.0.6

# COPY package.json /data/package.json
COPY settings.js /data/settings.js

# RUN mkdir -p /data/projects/.sshkeys/

# COPY ssh/known_hosts /usr/src/node-red/.ssh/known_hosts
# COPY ssh/id_rsa /usr/src/node-red/.ssh/id_rsa
# COPY ssh/id_rsa.pub /usr/src/node-red/.ssh/id_rsa.pub
# COPY ssh/id_rsa /data/projects/.sshkeys/admin_base
# COPY ssh/id_rsa.pub /data/projects/.sshkeys/admin_base.pub