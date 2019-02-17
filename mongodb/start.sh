# Ubuntu 16.04 
echo "********************************************************************************"
echo ""
echo "Setting up the host."
echo ""
echo "********************************************************************************"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
echo "********************************************************************************"
echo ""
echo "MongoDB"
echo ""
echo "********************************************************************************"
sleep 5
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod
echo "********************************************************************************"
echo ""
echo "Firewall"
echo ""
echo "********************************************************************************"
sleep 5
ufw allow from your_other_server_ip/32 to any port 27017
ufw enable
ufw status
