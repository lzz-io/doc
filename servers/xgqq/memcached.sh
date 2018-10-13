yum update -y
yum install cyrus-sasl cyrus-sasl-plain cyrus-sasl-devel -y
sed -i "s/MECH=pam/MECH=shadow/g" /etc/sysconfig/saslauthd

systemctl enable saslauthd.service
#service saslauthd start
systemctl start saslauthd.service

groupadd memcached
useradd -M -g memcached -s /sbin/nologin memcached
passwd memcached
#input

saslpasswd2 -a memcached -c memcached
#saslpasswd2 -c -a memcached memuser
#可以查看当前的SASL用户
sasldblistusers2

#########################
testsaslauthd -u memcached -p memcached
#testsaslauthd -u memcached -p memcached -s memcached

yum install libevent libevent-devel -y
#cd /usr/local/src
#wget http://src-xgqq.oss-cn-hangzhou.aliyuncs.com/libevent-2.0.22-stable.tar.gz
#tar xzvf libevent-2.0.22-stable.tar.gz
#cd libevent-2.0.22-stable
#./configure --prefix=/usr/local/libevent
#make clean
#make
#make install

cd /usr/local/src
wget http://memcached.org/files/memcached-1.4.25.tar.gz
tar xzvf memcached-1.4.25.tar.gz
cd memcached-1.4.25
#./configure --prefix=/usr/local/memcached --enable-sasl --with-libevent=/usr/local/libevent
./configure --prefix=/usr/local/memcached --enable-sasl
make clean
make
make install

##########################
chmod +x /etc/rc.d/rc.local
echo '/usr/local/memcached/bin/memcached -d -u root -p 21211 -m 3072' >> /etc/rc.d/rc.local

