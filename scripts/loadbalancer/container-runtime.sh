#!/bin/bash

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

# sudo apt-get install docker-ce docker-ce-cli containerd.io
#  apt-cache madison docker-ce

VERSION=18.06.3~ce~3-0~debian

sudo apt-get install docker-ce=${VERSION} containerd.io -y
