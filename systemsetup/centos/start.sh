#!/bin/bash

echo "********************************************************************************"
echo "Installing NVIDIA Drivers."
echo "********************************************************************************"

wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.78/NVIDIA-Linux-x86_64-410.78.run
chmod a+x NVIDIA-Linux-x86_64-410.78.run
./NVIDIA-Linux-x86_64-410.78.run -s --install-libglvnd

rm ./NVIDIA-Linux-x86_64-410.78.run 

echo "********************************************************************************"
echo "Installing NodeJS."
echo "********************************************************************************"

curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -

sudo yum install nodejs

echo "********************************************************************************"
echo "Installing NVSMI."
echo "********************************************************************************"

cd /etc
git clone https://github.com/philliplakis/nvsmi.git
cd nvsmi
npm install
npm install forever -g
forever start server.js

echo "********************************************************************************"
echo "Allowing 8989 Port for nvsmi."
echo "********************************************************************************"

firewall-cmd --zone=public --add-port=8989/tcp --permanent
firewall-cmd --reload

echo "********************************************************************************"
echo "Installing Cloud-Init + Allowing SSH."
echo "********************************************************************************"

yum -y install cloud-init

cd /etc/cloud/
sed -i '/ssh_pwauth:   0/c\ssh_pwauth:   1' cloud.cfg


