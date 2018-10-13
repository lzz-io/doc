#!/bin/bash

set -e

# if [[ `pwd` != '/opt' ]]; then
# 	cp $@ /opt
# 	cd /opt
# fi
cp $0 /opt
# pushd /opt
cd /opt

yum install -y wget

jdkVersion_big=8
jdkVersion_small=152
jdkPlatform=jdk-8u152-linux-x64
DOWNLOAD_URL="\
	\
	http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.rpm
	\
	"

wget --no-check-certificate --no-cookies \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" ${DOWNLOAD_URL}

yum install -y ${jdkPlatform}.rpm


cat >/etc/profile.d/java.sh <<EOF

# set java_home
# export JAVA_HOME=/usr/java/default
export JAVA_HOME=/usr/java/jdk1.${jdkVersion_big}.0_${jdkVersion_small}
export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
# cat /etc/profile

source /etc/profile
echo $JAVA_HOME
echo $CLASSPATH
echo $PATH

java -version

# popd
