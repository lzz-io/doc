# 使用Ubuntu镜像
FROM ubuntu

# 先更新源，设置使用非交互式安装，再安装tzdata
RUN sed -e 's|archive.ubuntu.com|mirrors.cernet.edu.cn|g' \
        -e 's|security.ubuntu.com|mirrors.cernet.edu.cn|g' \
        -i /etc/apt/sources.list.d/ubuntu.sources; \
    apt update -y; \
    DEBIAN_FRONTEND="noninteractive" \
    apt install -y ubuntu-minimal \
                    bash-completion \
                    vim \
                    openssh-server; \
    # root ssh login
    sed -e 's|#PermitRootLogin prohibit-password|PermitRootLogin yes|' \
        -e 's|#PermitEmptyPasswords no|PermitEmptyPasswords yes|' \
        -i /etc/ssh/sshd_config; \
    sed -i 's|#    . /etc/bash_completion|    . /etc/bash_completion|' /root/.bashrc; \
    #
    # 清除root密码
    passwd -d root;
    


# 设置时区
ENV TZ=Asia/Shanghai
# 创建一个我们期望的时区的软连接到localtime，并修改本机时区timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# systemd当在Docker 容器中作为 init 进程运行时，通常会配置监听SIGRTMIN+3某个信号，
# 以启动其托管服务的正确关闭。systemd 这确保服务以正确的顺序停止，并且资源被干净地释放，
# 从而防止数据损坏或资源泄漏。
STOPSIGNAL SIGRTMIN+3

# 使用CMD，在docker run时能覆盖此命令
# ENTRYPOINT ["/usr/lib/systemd/systemd"]
CMD ["/usr/lib/systemd/systemd"]
