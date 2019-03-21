$localIpAddress=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
$Vport=":5901"


C:\websockify\websockify\websockify.exe 6080 $($localIpAddress + $Vport) --web C:\noVNC-1.0.0\noVNC-1.0.0 --cert C:\noVNC-1.0.0\noVNC-1.0.0\self.pem
