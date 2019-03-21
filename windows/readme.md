# Install VNC & Auto Start...

##### TightVNC
    https://www.tightvnc.com/download/2.8.11/tightvnc-2.8.11-gpl-setup-64bit.msi

##### Install Windows Mirror Driver 
    https://www.tightvnc.com/download/dfmirage/dfmirage-setup-2.0.301.exe

##### Install Node.Js
    https://nodejs.org/dist/v10.15.0/node-v10.15.0-x64.msi

##### Websockify
    https://github.com/downloads/novnc/websockify/websockify.zip

##### noVNC
    https://github.com/novnc/noVNC/releases

##### Extract noVNC & Websockify
Place noVNC & Websockify in C:\

      notes:
      Make sure tightVNC port is set to :5901
      Windows Server needs rules to accept port :6080 inbound and outbound

Download dirtycerts and place inside noVNC folder

##### Create vnc.bat in c:\
      @ECHO OFF
      powershell -ExecutionPolicy ByPass -File "C:\vnc.ps1"

##### Create vnc.ps1 in c:\

      $localIpAddress=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
      $Vport=":5901"

      C:\websockify\websockify\websockify.exe 6080 $($localIpAddress + $Vport) --web C:\noVNC-1.0.0\noVNC-1.0.0


##### helpful guide
https://forums.highfidelity.com/t/vnc-in-vr-synchronized-virtual-desktops-updated-for-windows-10/14008
