# lzz.io docker file

#生产环境，最好指明具体版本如 centos:7
#更好的选择是alpine版
FROM httpd

#(已被弃用),推荐使用LABEL
#MAINTAINER lzz.io

#如果base image中也有标签，则继承，如果是同名标签，则覆盖。
#为了减少图层数量，尽量将标签写在一个LABEL指令中
LABEL author="lzz.io" \
		qq=1219331697 \
		url=lzz.io
		
### 环境变量
# 时区
#ENV TZ="Asia/Shanghai" \
#	PORT=80
ENV TZ="Asia/Shanghai"

#RUN set -x \
#		&& yum update -y \
#		&& yum clean all

## COPY与ADD优先使用前者
## 合理调整COPY与RUN的顺序
## 我们应该把变化最少的部分放在Dockerfile的前面，这样可以充分利用镜像缓存。

COPY ./conf/httpd.conf /usr/local/apache2/conf/

COPY ./html/ /usr/local/apache2/htdocs/


### EXPOSE 声明端口
#EXPOSE $PORT


### 数据卷
#VOLUME ["/data","/logs"]


## 添加HEALTHCHECK
## 运行容器时，可以指定--restart always选项。
## 当请求失败时，curl --fail 命令返回非0状态。
## 如果容器的确在运行，但是不可用(陷入死循环，配置错误)怎么办？
## 使用HEALTHCHECK指令可以让Docker周期性的检查容器的健康状况。
## 我们只需要指定一个命令，如果一切正常的话返回0，否则返回1。
#HEALTHCHECK CMD curl --fail http://localhost:$PORT || exit 1


#docker stop优雅的关闭容器，需要编写代码处理SIGTERM信号;默认10秒
#STOPSIGNAL SIGTERM

#容器启动时执行
#当指定多个时，只有最后一个起效
#ENTRYPOINT ["/bin/sh", "-c", "/usr/bin/ssserver -p $PORT -k $PASSWORD -m $METHOD"]

#COPY ./entrypoint.sh /
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

#容器启动后默认执行的命令及其参数
#能够被 docker run 后面跟的命令行参数替换
#当指定多个时，只有最后一个起效
#CMD ["/bin/sh", "-c", "/usr/bin/ssserver -p $PORT -k $PASSWORD -m $METHOD"]
#CMD ["start"]
#CMD ["httpd-foreground"]