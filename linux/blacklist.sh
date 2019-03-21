#!/bin/bash

echo "********************************************************************************"
echo "BlackList."
echo "********************************************************************************"
sleep 2

echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist lbm-nouveau" >> /etc/modprobe.d/blacklist.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist.conf
echo "alias nouveau off" >> /etc/modprobe.d/blacklist.conf
echo "alias lbm-nouveau off" >> /etc/modprobe.d/blacklist.conf

echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf

sudo update-initramfs -u

reboot
