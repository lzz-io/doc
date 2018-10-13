#!/bin/bash

#时间同步
#阿里云有内置时间同步，不需要设置
#cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#yum install ntp -y
#service ntpd stop
#ntpdate pool.ntp.org

yum update -y

# 挂载阿里云文件存储
yum install nfs-utils -y
mkdir /a
mount -t nfs4 172.16.0.3:/ /a
chmod +x /a/src/init.sh
cp /a/src/servers.tar.gz /usr/local
# auto script
echo -e '#! /bin/bash\n' >> /etc/rc.d/init.d/nas
echo '# nas    Automount Aliyun NAS in the specified direcotry.' >> /etc/rc.d/init.d/nas
echo '# chkconfig: 2345 11 89' >> /etc/rc.d/init.d/nas
echo -e '# description: aliyun nas\n' >> /etc/rc.d/init.d/nas
echo 'mount -t nfs4 172.16.0.3:/ /a' >> /etc/rc.d/init.d/nas
# mkdir /bak && echo 'mount -t nfs4 172.16.0.19:/ /bak' >> /etc/rc.d/init.d/nas
chmod +x /etc/rc.d/init.d/nas
chkconfig --add nas

#解压编译好的程序
cd /usr/local
tar xzvf servers.tar.gz

# apache2
yum install -y pcre-devel zlib-devel openssl-devel
groupadd apache
useradd -r -g apache -M -s /bin/false apache
sed -i -e '3i\# description: The Apache HTTP Server\n#' /usr/local/apache2/bin/apachectl
sed -i '3i\# chkconfig: 2345 85 15' /usr/local/apache2/bin/apachectl
sed -i '3i\# httpd    Startup script for the Apache HTTP Server' /usr/local/apache2/bin/apachectl
\cp -rf /a/src/conf/apache2/* /usr/local/apache2
sed -i "s/##HOSTNAME##/manager/g" `grep '##HOSTNAME##' -rl /usr/local/apache2/conf`
mkdir -p /a/logs/apache
sed -i "s/##BASE_LOGS##/\/a\/logs\/apache/g" `grep '##BASE_LOGS##' -rl /usr/local/apache2/conf`
\cp -f /usr/local/apache2/bin/apachectl /etc/rc.d/init.d/httpd
chmod +x /etc/rc.d/init.d/httpd
chkconfig --add httpd
chkconfig --list httpd
service httpd start

# jdk
cd /a/src
yum localinstall -y jdk-7u80-linux-x64.rpm

echo 'export JAVA_HOME=/usr/java/jdk1.7.0_80' >> /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
source /etc/profile

# tomcat
# tomcat18801
cd /usr/local/src/apache-tomcat-8.0.33/bin
rm -rf /usr/local/src/apache-tomcat-8.0.33/webapps/*
rm -rf commons-daemon-1.0.15-native-src
rm -rf tomcat-native-1.2.5-src
mkdir -p /usr/local/tomcat/tomcat18801
\cp -rf /usr/local/src/apache-tomcat-8.0.33/* /usr/local/tomcat/tomcat18801
\cp -rf /a/src/conf/tomcat/* /usr/local/tomcat/tomcat18801
sed -i "s/##HOSTNAME##/manager/g" `grep '##HOSTNAME##' -rl /usr/local/tomcat/tomcat18801`
sed -i "s/##TOMCAT_INSTANCE##/18801/g" `grep '##TOMCAT_INSTANCE##' -rl /usr/local/tomcat/tomcat18801`
sed -i "s/##TOMCAT_NUM##/1/g" `grep '##TOMCAT_NUM##' -rl /usr/local/tomcat/tomcat18801`
sed -i "s/##docBase##/\/a\/www\/manager.xgqq.com\/ROOT/g" `grep '##docBase##' -rl /usr/local/tomcat/tomcat18801`
mkdir -p /a/logs/tomcat
sed -i "s/##BASE_LOGS##/\/a\/logs\/tomcat/g" `grep '##BASE_LOGS##' -rl /usr/local/tomcat/tomcat18801`
sed -i "s/##TOMCAT_OUT##/\/a\/logs\/manager/g" `grep '##TOMCAT_OUT##' -rl /usr/local/tomcat/tomcat18801`
\cp -rf /usr/local/tomcat/tomcat18801/bin/daemon.sh /etc/init.d/tomcat18801
chmod +x /etc/init.d/tomcat18801
chkconfig --add tomcat18801
chkconfig --list tomcat18801
service tomcat18801 start
