# windows-cloudinit
File changes to get Windows to work with CloudInit

    on Proxmox Host
    
    wget https://raw.githubusercontent.com/philliplakis/Install-Scripts/master/windows/cloud-init/cloudinit.patch   
    patch /usr/share/perl5/PVE/QemuServer/Cloudinit.pm < cloudinit.patch
    
    nano /usr/share/perl5/PVE/API2/Qemu.pm
    ## see changes in Qemu.pm file in code
