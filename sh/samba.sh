#!/bin/bash

set -e


# 安装
yum -y install samba


# 配置
# samba配置文件在/etc/samba/smb.conf，修改这个配置文件在最后加入下面的配置：

# linux_share:共享名称，可以随便写
# path:共享文件夹的路径
# writable:是否可写
# [linux_share]
# path=/home/share
# writable = yes
# public=yes

# 注意下面的配置:

# [global]
#         workgroup = SAMBA
#         security = user
# 如果security = user，那么需要输入用户名和密码才可以访问，这样相对叫安全，
# 因此我们需要为samba创建一个用户。

# #创建系统用户share
# useradd share
# #创建samba用户
# smbpasswd -a share
smbpasswd -a admin

# 防火墙放行端口

# 启动samba服务
systemctl enable smb.service
systemctl start smb.service
