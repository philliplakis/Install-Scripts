#!/bin/bash

apt-get remove docker docker-engine docker.io
apt-get update 

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get update && apt-get install docker-ce

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

apt-get update

apt-get install -y nvidia-docker2
pkill -SIGHUP dockerd

docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi

docker pull ufoym/deepo
docker pull tensorflow/tensorflow
