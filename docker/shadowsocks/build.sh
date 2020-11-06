docker build -t registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks .

docker images -a

# docker tag registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks registry.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks

docker login -u 15590988@qq.com -p q1w2e3r4 registry-vpc.cn-hongkong.aliyuncs.com
docker push registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks

# # 目前SS端最推荐的加密以及obfs混淆如下：
# # 推荐加密方式：aes-256-gcm 、chacha20-ietf-poly1305、aes-128-gcm、aes-192-gcm （排名分先后）
# #
# # SS最佳推荐加密方式：aes-256-gcm，最佳 obfs：http 
# # 目前手机端、第三方路由固件多数已支持，建议使用以上推荐，PC客户端有待更新，相信不会等太久。

# # iso目前只支持 aes-256-cfb

yum update -y;
yum install -y yum-utils device-mapper-persistent-data lvm2;
yum-config-manager --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo;
yum install -y docker-ce;
systemctl disable firewalld;
systemctl stop firewalld;
systemctl enable docker;
systemctl restart docker;


docker pull shadowsocks/shadowsocks-libev;
docker run -d -p 8888:8388 -p 8888:8388/udp \
        -e PASSWORD=gfwsb  -e METHOD=aes-256-gcm -e TZ=CST-8 \
        --name=shadowsocks --restart=always \
        shadowsocks/shadowsocks-libev;


# 阿里云
# docker login -u 15590988@qq.com -p q1w2e3r4 registry-vpc.cn-hongkong.aliyuncs.com

# docker run -d -p 8888:8388 -p 8888:8388/udp \
    # -e PASSWORD=gfwsb -e METHOD=aes-256-gcm -e TZ=CST-8 \
    # --name=shadowsocks --restart=always \
    # registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks


# 腾讯云
# docker login -u 15590988@qq.com -p q1w2e3r4 registry.cn-hongkong.aliyuncs.com

# docker run -d -p 8888:8388 -p 8888:8388/udp \
    # -e PASSWORD=gfwsb -e METHOD=aes-256-gcm -e TZ=CST-8 \
    # --name=shadowsocks --restart=always \
    # registry.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks

