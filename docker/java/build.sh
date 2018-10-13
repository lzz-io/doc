docker build -t docker.xgqq.com/java .

docker images -a

# 批量删除tag为none的镜像
docker images|grep none|awk '{print $3}'|xargs docker rmi -f

docker tag docker.xgqq.com/java docker.xgqq.com/java:8
docker tag docker.xgqq.com/java docker.xgqq.com/java:jdk8

docker push docker.xgqq.com/java
docker push docker.xgqq.com/java:8
docker push docker.xgqq.com/java:jdk8
