# NodeRED Development IDE Server

Basic NodeRED server to allow an IDE. This augments the dockerhub node red image to add useful module and settings.

To run and useful commands:

```bash
# Prepare ssh keys and host file for git projects
mkdir ssh
export GIT_SERVER=<git_server_name>
ssh-keygen -f ssh/id_rsa
# Go get git server finger print
ssh-keyscan $GIT_SERVER >> ssh/fingerprintkey
ssh-keygen -lf ssh/fingerprintkey
cat ssh/fingerprintkey >> ssh/known_hosts

# Correct permission
# TODO room for improvement here
sudo chown $USER:$USER -R ssh
sudo chmod -R a-rw,ug+r ssh

# Prep a backup folder
mkdir backup certs

# Make a selfsign password
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

# Build server
./build.sh
# Run the IDE
./run.sh

# Pull settings.js from the nodered ide container
docker-compose exec ide cp /data/settings.js /backup/settings.js
docker-compose exec ide cp /data/flow.js /backup/flow.js
```
