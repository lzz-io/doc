docker build -t docker.xgqq.com/svn .

docker images -a

# 批量删除tag为none的镜像
docker images|grep none|awk '{print $3}'|xargs docker rmi -f

docker push docker.xgqq.com/svn
