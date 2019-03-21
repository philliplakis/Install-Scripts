## Install-Scripts

#### / docker  
    start.sh    - Installs Docker & Nvidia Docker 2
    deepo-cu10  - Converts ufyom/deepo to Cuda 10
    
#### / linux  
    / centos
        start.sh    -   Prepares Cent for Cloud-Init & Qemu
    / tensorbox
        start.sh    -   Prepares Ubuntu for Machine Learning & Deep Learing
    / ubuntu
        start.sh    -   Prepares Ubuntu for Cloud-Init & Qemu
    blacklist.sh    -   Blacklists Noveau 
    welcome         -   Welcome message via SSH.

#### / mongodb  
    start.sh        -   Prepares Ubuntu for MongoDB

#### / nvidia
    cuda10.sh       -   Installs CUDA 10 + Nvidia Driver
    
#### / proxmox
    dnsbug.sh       -   Ubuntu DNS bug fix on Cloud-Init
    limitzfs.sh     -   Script to limit ZFS Ram usage
    
#### / windows
    / cloud-init
        Cloud Init for Windows + Proxmox fixes
    / dirtycerts
        SSL certificates for noVNC
    / newusers
        checkpoint.ps1  -   Creates a Restore checkpoint for Windows
        create_user.ps1 -   Creates a new user
        restore.ps1     -   Restores checkpoint created above.
    nvidiadriver.md     -   Windows 1803 + Nvidia driver not supported BUG
    vnc.bat             -   BAT file for Task Scheduler
    vnc.ps1             -   Script to begin noVNC + Websockets on startup.


    
