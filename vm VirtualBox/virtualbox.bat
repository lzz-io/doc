:: 开机启动vm虚拟机 c101

@echo off
echo 请勿关闭此窗口，服务器在后台运行
::cd "C:\Program Files\Oracle\VirtualBox"
::VBoxHeadless --startvm "c101" "c102"
"C:\Program Files\Oracle\VirtualBox\VBoxManage" startvm --type headless "c101"

:: 然后建此bat文件放到放到[开始]->[程式集]->[启动]内，即可在开机时同时启动Virtualbox虚拟机器的系统了。
:: win10 cmd ==>> shell:startup
