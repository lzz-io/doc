#!/bin/bash

# server 1
docker network create -d=overlay --subnet=10.10.0.0/16 --attachable mynet


# A key’s length must be between 6 and 1024 characters and 
# may only contain characters in the base64 set.
# NOTE
# On UNIX systems, the keyfile must not have group or world permissions. 
# On Windows systems, keyfile permissions are not checked.
mkdir -p /data/mongo
openssl rand -base64 756 > /data/mongo/key
chmod 400 /data/mongo/key
chown 999 /data/mongo/key


###############################################################################
## configsvr
###############################################################################
# server 1
docker rm -f s1.cfg.mongo
docker volume prune -f
docker rm -f s1.cfg.mongo
docker run -d --restart always --network mynet \
        --hostname s1.cfg.mongo --name s1.cfg.mongo \
        -v s1.cfg.mongo-configdb:/data/configdb \
        -v s1.cfg.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        --port 27017 --configsvr --replSet configrs --auth --keyFile /data/mongo/key --bind_ip 0.0.0.0

# server 2
docker rm -f s2.cfg.mongo
docker volume prune -f
docker rm -f s2.cfg.mongo
docker run -d --restart always --network mynet \
        --hostname s2.cfg.mongo --name s2.cfg.mongo \
        -v s2.cfg.mongo-configdb:/data/configdb \
        -v s2.cfg.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        --port 27017 --configsvr --replSet configrs --auth --keyFile /data/mongo/key --bind_ip 0.0.0.0

# server 3
docker rm -f s3.cfg.mongo
docker volume prune -f
docker rm -f s3.cfg.mongo
docker run -d --restart always --network mynet \
        --hostname s3.cfg.mongo --name s3.cfg.mongo \
        -v s3.cfg.mongo-configdb:/data/configdb \
        -v s3.cfg.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        --port 27017 --configsvr --replSet configrs --auth --keyFile /data/mongo/key --bind_ip 0.0.0.0

# 配置 configsvr1
docker exec -it s1.cfg.mongo bash
mongo
rs.initiate()

use admin
db.createUser(
  {
    user: "root",
    pwd: "q1w2e3r4",
    roles: [
       { role: "root", db: "admin" }
    ]
  }
)

# exit


mongo
use admin
db.auth("root","q1w2e3r4")
# or
# mongo -u root -p 'q1w2e3r4' --authenticationDatabase admin

rs.add("s1.cfg.mongo:27017")
rs.add("s2.cfg.mongo:27017")
rs.add("s3.cfg.mongo:27017")

###############################################################################
## shardsvr
## 非副本集模式，生产环境用副本集模式，参考configserver配置
###############################################################################
# shard
# server 1
docker rm -f s1.shard.mongo
docker volume prune -f
docker rm -f s1.shard.mongo
docker run -d --restart always --network mynet \
        --hostname s1.shard.mongo --name s1.shard.mongo \
        -v s1.shard.mongo-configdb:/data/configdb \
        -v s1.shard.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        --port 27017 --shardsvr --auth --keyFile /data/mongo/key --bind_ip 0.0.0.0
        # 副本集模式 --replSet shardrs

# 初始化用户名密码
docker exec -it s1.shard.mongo bash
mongo

use admin
db.createUser(
  { user: "root", pwd: "q1w2e3r4", roles: [ { role: "root", db: "admin" } ] }
)
# exit

mongo
use admin
db.auth("root","q1w2e3r4")
# or
# mongo -u root -p 'q1w2e3r4' --authenticationDatabase admin
         
# server 2
docker rm -f s2.shard.mongo
docker volume prune -f
docker rm -f s2.shard.mongo
docker run -d --restart always --network mynet \
        --hostname s2.shard.mongo --name s2.shard.mongo \
        -v s2.shard.mongo-configdb:/data/configdb \
        -v s2.shard.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        --port 27017 --shardsvr --auth --keyFile /data/mongo/key --bind_ip 0.0.0.0

# 初始化用户名密码
docker exec -it s2.shard.mongo bash
mongo

use admin
db.createUser(
  { user: "root", pwd: "q1w2e3r4", roles: [ { role: "root", db: "admin" } ] }
)
# exit

mongo
use admin
db.auth("root","q1w2e3r4")
# or
# mongo -u root -p 'q1w2e3r4' --authenticationDatabase admin

# server 3
docker rm -f s3.shard.mongo
docker volume prune -f
docker rm -f s3.shard.mongo
docker run -d --restart always --network mynet \
        --hostname s3.shard.mongo --name s3.shard.mongo \
        -v s3.shard.mongo-configdb:/data/configdb \
        -v s3.shard.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        --port 27017 --shardsvr --auth --keyFile /data/mongo/key --bind_ip 0.0.0.0

# 初始化用户名密码
docker exec -it s3.shard.mongo bash
mongo

use admin
db.createUser(
  { user: "root", pwd: "q1w2e3r4", roles: [ { role: "root", db: "admin" } ] }
)
# exit

mongo
use admin
db.auth("root","q1w2e3r4")
# or
# mongo -u root -p 'q1w2e3r4' --authenticationDatabase admin


###############################################################################
## mongos
###############################################################################
# server 1
docker rm -f s1.mongos.mongo
docker volume prune -f
docker rm -f s1.mongos.mongo
docker run -d --restart always --network mynet \
        -p 27017:27017 \
        --hostname s1.mongos.mongo --name s1.mongos.mongo \
        -v s1.mongos.mongo-configdb:/data/configdb \
        -v s1.mongos.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        mongos --configdb configrs/s1.cfg.mongo:27017,s2.cfg.mongo:27017,s3.cfg.mongo:27017 \
        --keyFile /data/mongo/key --bind_ip 0.0.0.0

# server 2
docker rm -f s2.mongos.mongo
docker volume prune -f
docker rm -f s2.mongos.mongo
docker run -d --restart always --network mynet \
        -p 27017:27017 \
        --hostname s2.mongos.mongo --name s2.mongos.mongo \
        -v s2.mongos.mongo-configdb:/data/configdb \
        -v s2.mongos.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        mongos --configdb configrs/s1.cfg.mongo:27017,s2.cfg.mongo:27017,s3.cfg.mongo:27017 \
        --keyFile /data/mongo/key --bind_ip 0.0.0.0

# server 3
docker rm -f s3.mongos.mongo
docker volume prune -f
docker rm -f s3.mongos.mongo
docker run -d --restart always --network mynet \
        -p 27017:27017 \
        --hostname s3.mongos.mongo --name s3.mongos.mongo \
        -v s3.mongos.mongo-configdb:/data/configdb \
        -v s3.mongos.mongo-db:/data/db \
        -v /data/mongo/key:/data/mongo/key \
        mongo \
        mongos --configdb configrs/s1.cfg.mongo:27017,s2.cfg.mongo:27017,s3.cfg.mongo:27017 \
        --keyFile /data/mongo/key --bind_ip 0.0.0.0


####################################
# 初始化 shard
####################################
docker exec -it s1.mongos.mongo bash

mongo
use admin
db.auth("root","q1w2e3r4")
# or
# mongo -u root -p 'q1w2e3r4' --authenticationDatabase admin

# sh.addShard( "<replSetName>/s1.shard.mongo:27017")
sh.addShard( "s1.shard.mongo:27017")
sh.addShard( "s2.shard.mongo:27017")
sh.addShard( "s3.shard.mongo:27017")


# 作用：数据库中的表分布到不同节点，但是每个表中的数据不分片
sh.enableSharding("finance")

# 作用：表中的数据分片到不同节点
# sh.shardCollection("finance.user", { "username" : "hashed" } )
sh.shardCollection("finance.user", { "_id" : "hashed" } )


###############################################################################
## busybox 测试用，如ping等
###############################################################################
docker run -it --network mynet busybox sh

docker exec -it s1.mongos.mongo bash

mongo
use admin
db.auth("root","q1w2e3r4")
# or
mongo -u root -p 'q1w2e3r4' --authenticationDatabase admin

use finance

db

for(i=1;i<=10000;i++){ db.user.insert( { username:i } ) }

db.stats()

db.user.stats()

# db.dropDatabase()

use admin
# db.runCommand( { movePrimary: <databaseName>, to: <newPrimaryShard> } )
db.runCommand( { movePrimary : "finance", to : "shard0000" } )

