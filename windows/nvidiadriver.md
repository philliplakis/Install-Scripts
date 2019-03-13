# Fix Nvidia Driver issue
### Windows 1803 + Nvidia driver not supported

1. To check whether you have the DCH NVIDIA graphics driver installed on your system, 
you can use Regedit to check HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm 
for a value called "DCHUVen". If it is present you are currently running an NVIDIA UWD/DCH driver.

2. Go to Device Manager, open the NVIDIA graphics adapter, go to "Details" and select "Inf Name". 
Make note of the value, which in our case is "oem6.inf", but this will differ between systems, so don't skip this step.

3. Now open a command prompt with administrative privileges (Press Windows key, type "cmd", right-click, select "Run as Administrator".
Next, type the following command into the command prompt "pnputil /delete-driver oemX.inf /uninstall", 
replace "X" with the number you got from the first step (in our case we use oem6.inf).

4. The last step is to run "sc delete nvlddmkm" in the same command prompt, which properly 
removes the leftovers of the NVIDIA DCH driver.

Now you can download and install the NVIDIA driver without any problems, no reboot is needed through 
all these steps. We recommend doing a custom installation of the driver at this point, with the "clean install" option activated, 
to make sure all leftovers are removed.
