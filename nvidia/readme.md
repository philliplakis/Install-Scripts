# NVIDIA-SMI
### List all available NVIDIA devices
    nvidia-smi -L

### List certain details about each GPU
    nvidia-smi --query-gpu=index,name,uuid,serial --format=csv

### List GPU details
    nvidia-smi -i 0 -q
    
### Set GPU power limit 
    nvidia-smi -pl 100 
100 = 100w . 

### See clock speeds
    nvidia-smi -q -d CLOCK

### Get GPU Utilisation logs    
    nvidia-smi -q -g 0 -d UTILIZATION -l
    
    Output:
    ==============UTIL LOG==============

    Timestamp                       : Tue Nov 22 11:50:05 2018

    Driver Version                  : 275.19

    Attached GPUs                   : 2

    GPU 0:1:0
        Utilization
            Gpu                     : 0 %
            Memory                  : 0 %
    
### Get NVlink status
    nvidia-smi nvlink --status -i 0
    
### Long NVlink status
    nvidia-smi nvlink --status
    
    Output:
    ==============STATUS==============
    GPU 0: Tesla V100-SXM2-32GB
	    Link 0: 25.781 GB/s
	    Link 1: 25.781 GB/s
	    Link 2: 25.781 GB/s
	    Link 3: 25.781 GB/s
	    Link 4: 25.781 GB/s
	    Link 5: 25.781 GB/s
    GPU 1: Tesla V100-SXM2-32GB
	    Link 0: 25.781 GB/s
	    Link 1: 25.781 GB/s
	    Link 2: 25.781 GB/s
	    Link 3: 25.781 GB/s
	    Link 4: 25.781 GB/s
	    Link 5: 25.781 GB/s


### Show system topology
    Nvidia-smi topo --matrix

    Output:
    ==============MATRIX==============
            GPU0    GPU1    CPU Affinity
    GPU0     X      NV4     1-1,3-3,5-5,7-7
    GPU1    NV4      X      1-1,3-3,5-5,7-7
