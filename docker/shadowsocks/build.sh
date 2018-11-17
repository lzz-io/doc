docker build -t registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks .

docker images -a

docker tag registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks registry.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks

docker login -u 15590988@qq.com -p q1w2e3r4 registry-vpc.cn-hongkong.aliyuncs.com
docker push registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks



yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum update -y
yum install -y docker-ce
yum install -y docker
systemctl disable firewalld
systemctl stop firewalld
systemctl enable docker
systemctl restart docker

docker login -u 15590988@qq.com -p q1w2e3r4 registry-vpc.cn-hongkong.aliyuncs.com

docker run -d -p 44443:8388 -p 44443:8388/udp \
    -e PASSWORD=gfwsb -e METHOD=aes-256-cfb -e TZ=CST-8 \
    --name=shadowsocks --restart=always \
    registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/shadowsocks