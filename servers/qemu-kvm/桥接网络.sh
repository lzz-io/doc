## 在host机器配置桥接网络

# 1.查看网卡是否工作
ifconfig

# 2.备份network-scripts网络脚本文件
# 注意:不要把文件copy到/etc/sysconfig/network-scripts/目录或者其子目录
cp /etc/sysconfig/network-scripts/ifcfg-eth0 /root/.

# 3.进入network-scripts目录
# 进入 /etc/sysconfig/network-scripts/目录.
cd /etc/sysconfig/network-scripts/

# 4.为桥接新建配置文件
# 为Linux的bridge创建一个新的配置文件为
# /etc/sysconfig/network-scripts/ifcfg-br0,
# 这里br0是bridge网桥的名字,同eth0类似.使用以下命令
cp ifcfg-eth0 ifcfg-br0
# 具体的内容是基于已有的配置文件来进行的.

# 5.编辑bridge网桥配置文件
# static ip配置
# /etc/sysconfig/network-scripts/ifcfg-eth0    
DEVICE=eth0
TYPE=Ethernet
HWADDR=00:14:5E:C2:1E:40
ONBOOT=yes
NM_CONTROLLED=no
BRIDGE=br0

# /etc/sysconfig/network-scripts/ifcfg-br0
DEVICE=br0
TYPE=Bridge
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=10.10.1.152
NETMASK=255.255.255.0
ONBOOT=yes
# GATEWAY=192.168.1.1
# DNS1=192.168.1.1
# 如不能上网，可能需要GATEWAY,DNS1

# 6.重启网络服务
# 重启网络以验证网络配置是否工作.


# 配置桥接网络
# 系统如果安装了桌面环境，网络会由NetworkManager进行管理，
# NetworkManager不支持桥接，需要关闭NetworkManger:

chkconfig NetworkManager off
chkconfig network on
service NetworkManager stop
service network start

