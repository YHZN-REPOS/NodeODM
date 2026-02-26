#!/bin/bash

if [ -z "$NVM_DIR" ]; then
    echo "Error: NVM_DIR environment variable is not set" >&2
    exit 1
fi
if [ -z "$NODE_VERSION" ]; then
    echo "Error: NODE_VERSION environment variable is not set" >&2
    exit 1
fi

for i in {1..20}; do
    apt-get update && apt-get install -y curl gpg-agent ca-certificates && break
    echo "apt-get failed, retrying... ($i/20)"
    sleep 30
done

mkdir -p $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source $NVM_DIR/nvm.sh
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION

for i in {1..20}; do
    apt-get install -y unzip p7zip-full && npm install -g nodemon@2.0.22 && break
    echo "apt-get failed, retrying... ($i/20)"
    sleep 30
done

for i in {1..5}; do
    npm install --production && break
    echo "npm install failed, retrying... ($i/5)"
    npm cache clean --force || true
    rm -rf node_modules
    sleep 15
done

if [ "$i" -eq 5 ]; then
    echo "npm install failed after 5 attempts" >&2
    exit 1
fi
