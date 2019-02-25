# Fix no DNS via CloudInit on Ubuntu.

echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
