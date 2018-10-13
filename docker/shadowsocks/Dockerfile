# lzz.io docker file
FROM centos

#(已被弃用),推荐使用LABEL
#MAINTAINER lzz.io

#如果base image中也有标签，则继承，如果是同名标签，则覆盖。
#为了减少图层数量，尽量将标签写在一个LABEL指令中
LABEL author="lzz.io"

# 时区
ENV TZ="Asia/Shanghai"

#ssserver -h
ENV SERVER_PORT=8388 \
	PASSWORD=password \
	METHOD=aes-256-cfb

RUN set -x \
		&& yum install git python-setuptools -y && easy_install pip \
		&& pip install git+https://github.com/shadowsocks/shadowsocks.git@master \
		&& yum clean all

#docker stop优雅的关闭容器，需要编写代码处理SIGTERM信号
#STOPSIGNAL SIGTERM

#容器启动时执行
#当指定多个时，只有最后一个起效
#ENTRYPOINT ["ssserver", "-p 443", "-k password -m aes-256-cfb"]
#COPY ./entrypoint.sh /
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
#CMD ["echo","CMD"]

EXPOSE $SERVER_PORT

#容器启动后默认执行的命令及其参数
#能够被 docker run 后面跟的命令行参数替换
#当指定多个时，只有最后一个起效
CMD ["/bin/sh", "-c", "/usr/bin/ssserver -p $SERVER_PORT -k $PASSWORD -m $METHOD"]
