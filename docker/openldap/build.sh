docker build -t registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/openldap .

docker images -a

# docker tag registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/openldap \
#             registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/openldap

docker login -u 15590988@qq.com -p q1w2e3r4 registry-vpc.cn-hongkong.aliyuncs.com
docker push registry-vpc.cn-hongkong.aliyuncs.com/lzz-io/openldap

