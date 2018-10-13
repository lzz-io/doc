#!/bin/bash

set -e


# 有几个坑需要注意一下：

# 安装CentOS7选语言的时候，最好选择英文版，否则后面Ambari注册机器时死活注册不上
# （不要问我是怎么发现这个原因的，说多了都是泪，猜测要不是时区问题要不就是语言问题，
# 反正选这个就好使了）
# vi /etc/locale.conf
# LANG="en_US.UTF-8"
# reboot

# 需要选择安装模式时，选GNOME Desktop模式就好，对大多数人都方便使用。
# 如果选最小版的话，ifconfig命令等工具包还得自己安装，略麻烦。
# 注意：在右面的附件组件中，最好把Development Tools等附加插件都装上，
# 因为后面安装scipy等等python的packages时需要编译器，否则还要自己安装gcc,g++等C/C++编译器。


wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum repolist

yum install -y ambari-server

ambari-server setup
# ambari-server reset
# ambari-server setup

# Run the following command on the Ambari Server host:
ambari-server start
# http://<your.ambari.server>:8080
# admin/admin

# To check the Ambari Server processes:
ambari-server status

# To stop the Ambari Server:
ambari-server stop

