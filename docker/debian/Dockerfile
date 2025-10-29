# 使用debian镜像
FROM debian

# 不能有多余的空格
RUN echo '\
Types: deb\n\
URIs: http://mirrors.cernet.edu.cn/debian\n\
Suites: trixie trixie-updates trixie-backports sid\n\
Components: main contrib non-free non-free-firmware\n\
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg\n\
\n\
Types: deb\n\
URIs: http://mirrors.cernet.edu.cn/debian-security\n\
Suites: trixie-security\n\
Components: main contrib non-free non-free-firmware\n\
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg\n\
' > /etc/apt/sources.list.d/debian.sources; \
    #
    apt update -y; \
    DEBIAN_FRONTEND="noninteractive" \
    apt install -y systemd \
                    bash-completion \
                    curl \
                    openssh-server \
                    net-tools \
                    vim \
                    wget; \
    # root ssh login
    sed -e 's|#PermitRootLogin prohibit-password|PermitRootLogin yes|' \
        -e 's|#PermitEmptyPasswords no|PermitEmptyPasswords yes|' \
        -i /etc/ssh/sshd_config; \
    sed -e "s|# export LS_OPTIONS='--color=auto'|export LS_OPTIONS='--color=auto -a'|g" \
        -e 's|# alias|alias|g' \
        -i /root/.bashrc; \
    echo '. /etc/profile' >> /root/.bashrc; \
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
