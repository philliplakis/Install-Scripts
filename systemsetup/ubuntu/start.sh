#!/bin/bash
# Ubuntu Minimal 16.04

echo "********************************************************************************"
echo "Update / NVIDIA / VNC"
echo "********************************************************************************"
sleep 2

wget https://raw.githubusercontent.com/philliplakis/gpu-vnc/master/start.sh
bash start.sh -y

echo "********************************************************************************"
echo "Cloud-Init Install"
echo "********************************************************************************"
sleep 2

apt-get install cloud-init -y

echo "********************************************************************************"
echo "Installing NodeJS + NPM."
echo "********************************************************************************"
sleep 2

apt-get install nodejs -y
sudo apt install npm -y
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
apt-get install nodejs -y

echo "********************************************************************************"
echo "Installing NVSMI."
echo "********************************************************************************"
sleep 2

cd /etc
git clone https://github.com/philliplakis/nvsmi.git
cd nvsmi
npm install
npm install forever -g

echo 'forever start /etc/nvsmi/server.js' >> ~/.bashrc

echo "********************************************************************************"
echo "Setup welcome message"
echo "********************************************************************************"

mkdir /etc/ssh/banner/
cd /etc/ssh/banner/
wget https://raw.githubusercontent.com/philliplakis/cheatsheets/master/systemsetup/welcome
cd /etc/ssh/
echo "Banner /etc/ssh/banner/welcome" >> ./sshd_config
cd

echo "********************************************************************************"
echo "Rebooting"
echo "********************************************************************************"
sleep 1
echo "3..."
sleep 1
echo "2..."
sleep 1
echo "1..."
sleep 1
reboot
