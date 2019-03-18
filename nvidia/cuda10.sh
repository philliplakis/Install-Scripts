sudo service lightdm stop


wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.105_418.39_linux.run

chmod +x cuda_10.1.105_418.39_linux.run

sudo ./cuda_10.1.105_418.39_linux.run --silent --toolkit --samples

wget http://us.download.nvidia.com/XFree86/Linux-x86_64/418.43/NVIDIA-Linux-x86_64-418.43.run

sudo bash NVIDIA-Linux-x86_64-418.43.run
