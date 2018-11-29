netsh interface ip set address name="WLAN" source=static addr=172.16.3.151 mask=255.255.0.0 gateway=172.16.0.1

netsh interface IP set dns "WLAN" static 180.168.255.118

netsh interface ip add dns "WLAN" 116.228.111.18 index=2

pause