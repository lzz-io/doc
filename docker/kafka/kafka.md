# kafka

## windows

单机

```bat
###start /b run.bat。就相当于Linux下的run.sh &

start /b bin\windows\zookeeper-server-start.bat config/zookeeper.properties

start /b bin\windows\kafka-server-start.bat config/server.properties

bin\windows\kafka-topics.bat --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
### test
bin\windows\kafka-topics.bat --list --bootstrap-server localhost:9092

bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic test

bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic test --from-beginning

```

集群

```bat
start /b bin\windows\zookeeper-server-start.bat config/zookeeper.properties

start /b bin\windows\kafka-server-start.bat config/server-0.properties
start /b bin\windows\kafka-server-start.bat config/server-1.properties
start /b bin\windows\kafka-server-start.bat config/server-2.properties
cd bin\windows


### 创建一个拥有3个副本的topic:
#bin\windows\kafka-topics.bat --create --bootstrap-server localhost:9092 --replication-factor 3 --partitions 1 --topic my-replicated-topic
bin\windows\kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 3 --partitions 3 --topic test

### 现在我们搭建了一个集群，怎么知道每个节点的信息呢？运行“"describe topics”命令就可以了：
bin\windows\kafka-topics.bat --describe --zookeeper localhost:2181
bin\windows\kafka-topics.bat --describe --zookeeper localhost:2181 --topic test

### topic list
bin\windows\kafka-topics.bat --list --zookeeper localhost:2181
bin\windows\kafka-topics.bat --list --bootstrap-server localhost:9092

### 删除topic
# 需要server.properties中设置delete.topic.enable=true否则只是标记删除或者直接重启。
bin\windows\kafka-topics.bat --delete --zookeeper localhost:2181 --topic test

### 发topic，须连接kafka
bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic test

### 消费topic
bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic test --from-beginning

```

