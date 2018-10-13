#!/bin/bash

set -e

# if [[ `pwd` != '/opt' ]]; then
# 	cp $@ /opt
# 	cd /opt
# fi
cp $0 /opt
pushd /opt

# yum install -y wget
yum install -y epel-release
yum install -y axel

mavenVersion=3.5.0
DOWNLOAD_URL=" \
	http://www-us.apache.org/dist/maven/maven-3/${mavenVersion}/binaries/apache-maven-${mavenVersion}-bin.tar.gz \
	\
	"

# wget -O apache-maven-bin.tar.gz ${DOWNLOAD_URL}
axel -n 10 ${DOWNLOAD_URL}
mkdir -p /usr/local/maven
tar xzvf apache-maven-${mavenVersion}-bin.tar.gz -C /usr/local/maven --strip-components=1

cat >>/etc/profile <<EOF

# set maven_home
export MAVEN_HOME=/usr/local/maven
export PATH=\$PATH:\$MAVEN_HOME/bin
EOF
# cat /etc/profile.d/maven.sh

source /etc/profile
echo $MAVEN_HOME
echo $PATH

mvn --version

popd
