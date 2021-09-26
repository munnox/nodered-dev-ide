# NodeRED Development IDE Server

Basic NodeRED server to allow an IDE. This augments the dockerhub node red image to add useful module and settings.

To run:

```bash
# Prepare ssh keys and host file for git projects
mkdir ssh
ssh-keygen -f ssh/id_rsa
ssh-keyscan <git_server_name> >> ssh/fingerprintkey
ssh-keygen -lf fingerprintkey
cat fingerprintkey >> ssh/known_hosts
# Correct permission
# TODO room for improvement here
sudo chown 1000:1000 -R ssh

# Prep a backup folder
mkdir backup

# Build server
docker-compose build --no-cache
# Run the IDE
docker-compose up -d

# Pull settings.js from the nodered ide container
docker-compose exec ide cp /data/settings.js /backup/settings.js
```
