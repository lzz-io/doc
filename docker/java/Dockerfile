# q1219331697 docker file
FROM docker.xgqq.com/centos:7

MAINTAINER q1219331697 <1219331697@qq.com>

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm

RUN yum localinstall jdk-8u112-linux-x64.rpm -y && \
	rm -rf jdk-8u112-linux-x64.rpm
