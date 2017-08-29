#!/usr/bin/env bash

apt-get update -qq > /dev/null
apt-get dist-upgrade -y
apt-get install -y tmux net-tools vim htop


#### dokku shit ####

echo "dokku dokku/vhost_enable boolean true" | debconf-set-selections
wget https://raw.githubusercontent.com/dokku/dokku/v0.10.3/bootstrap.sh;
DOKKU_TAG=v0.10.3 bash bootstrap.sh

cat /tmp/id_rsa.pub | sshcommand acl-add dokku poop

# postgres
dokku plugin:install https://github.com/dokku/dokku-postgres.git

# redis
dokku plugin:install https://github.com/dokku/dokku-redis.git

# nats io
dokku plugin:install https://github.com/dokku/dokku-nats.git nats

dokku postgres:create poop-database
dokku redis:create poop-redis
dokku nats:create poop-nats
