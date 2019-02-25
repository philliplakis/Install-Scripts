#/bin/bash
# Limit ZFS to 32GB

cd /etc/modprobe.d/

cat > zfs.conf <<EOF
options zfs zfs_arc_max=34359738368 
EOF

cd ../

update-initramfs -u
