#!/bin/bash
# rm ./.vnc/passwd
# yum reinstall x

echo "********************************************************************************"
echo "Update"
echo "********************************************************************************"

yum update -y

echo "********************************************************************************"
echo "Installing NVIDIA Drivers."
echo "********************************************************************************"
sleep 2

yum install gcc kernel-devel kernel-headers -y
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.78/NVIDIA-Linux-x86_64-410.78.run
chmod a+x NVIDIA-Linux-x86_64-410.78.run
./NVIDIA-Linux-x86_64-410.78.run -s --install-libglvnd

rm ./NVIDIA-Linux-x86_64-410.78.run 

echo "********************************************************************************"
echo "Installing NodeJS."
echo "********************************************************************************"
sleep 2

curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -

sudo yum install nodejs

echo "********************************************************************************"
echo "Installing NVSMI."
echo "********************************************************************************"
sleep 2

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
sleep 2

yum install cloud-init -y

cd /etc/cloud/
sed -i '/ssh_pwauth:   0/c\ssh_pwauth:   1' cloud.cfg

echo "********************************************************************************"
echo "TurboVNC + VirtualGL"
echo "********************************************************************************"

sudo yum install turbovnc -y
sudo yum install VirtualGL -y
vglserver_config

echo "********************************************************************************"
echo "noVNC."
echo "********************************************************************************"
sleep 2

git clone https://github.com/novnc/noVNC.git
mv ./noVNC /opt/noVNC && \
chmod -R a+w /opt/noVNC && \

cd /etc/ssl
openssl req -x509 -nodes -newkey rsa:2048 -keyout self.pem -out self.pem -days 365
cd

echo "********************************************************************************"
echo "Allowing 6080 Port for noVNC."
echo "********************************************************************************"

firewall-cmd --zone=public --add-port=6080/tcp --permanent
firewall-cmd --reload

echo "********************************************************************************"
echo "Install Desktop + X-Server"
echo "********************************************************************************"
sleep 2

yum install gdm
yum groupinstall "X Window System"
yum groupinstall "MATE Desktop"
nvidia-xconfig 
systemctl enable gdm.service

systemctl set-default graphical.target

mkdir -p ~/.vnc
cd ~/.vnc/
cat > xstartup.turbovnc <<EOF
# Add the following line to ensure you always have an xterm available.
( while true ; do xterm ; done ) &
# Uncomment the following two lines for normal desktop:
unset SESSION_MANAGER
exec /etc/X11/xinit/xinitrc
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
xterm -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
twm &
EOF
cd ../
chmod a+x ~/.vnc/xstartup.turbovnc

/opt/TurboVNC/bin/vncserver
chmod -f 777 /tmp/.X11-unix
touch ~/.Xauthority
xauth generate :0 . trusted

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
