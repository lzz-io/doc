# lzz.io Dockerfile

## 生产环境，最好指明具体版本如 centos:7
## 更好的选择是alpine版
FROM centos

## (已被弃用),推荐使用LABEL
## MAINTAINER lzz.io

## 如果base image中也有标签，则继承，如果是同名标签，则覆盖。
## 为了减少图层数量，尽量将标签写在一个LABEL指令中
LABEL author="lzz.io" \
		qq=1219331697 \
		url=lzz.io
		
### 环境变量
# 时区
#ENV TZ="Asia/Shanghai" \
#	PORT=80
#ENV TZ="Asia/Shanghai"
ENV TZ=CST-8 \
	container=docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
	systemd-tmpfiles-setup.service ] || rm -f $i; done); \
	rm -f /lib/systemd/system/multi-user.target.wants/*;\
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]