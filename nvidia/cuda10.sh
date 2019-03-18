#!/bin/bash

service lightdm stop
apt-get update
apt-get upgrade
apt-get install build-essential

wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.105_418.39_linux.run

chmod +x cuda_10.1.105_418.39_linux.run

sudo ./cuda_10.1.105_418.39_linux.run 
