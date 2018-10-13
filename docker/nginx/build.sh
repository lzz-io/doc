docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx .

docker images -a


#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx:1

docker login -u 15590988@qq.com -p admin888 registry-vpc.cn-hongkong.aliyuncs.com
docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/nginx:1