#!/bin/bash

set -e

# yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y
yum groupinstall -y "GNOME Desktop"

# 更新系统的运行级别
# CentOS操作系统具有7中运行级别，
# 其中运行级别5代表X11控制台，在登陆后会自动进入图形GUI模式。
# 所以，如果我们想要让GUI界面生效，还需要更新系统的运行级别：
ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target

# 重启系统
# 图形化界面设置完毕后，需要重新启动系统才能生效：
reboot

# windows远程桌面登录
yum install -y epel-release
yum install -y xrdp
systemctl enable xrdp
systemctl start xrdp

# 打开防火墙3389端口
# firewall-cmd  --permanent --zone=public --add-port=3389/tcp
# firewall-cmd --reload
systemctl stop firewalld.service
systemctl disable firewalld.service

# 查看xrdp服务是否正常启动
systemctl status xrdp.service
ss -antup|grep xrdp

