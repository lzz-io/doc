docker build -t registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd .

docker images -a

#docker tag registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd:2

docker login -u 15590988@qq.com -p admin888 registry-vpc.cn-hongkong.aliyuncs.com
docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd
#docker push registry-vpc.cn-hongkong.aliyuncs.com/io-lzz/httpd:2
