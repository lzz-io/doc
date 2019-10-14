# kafka

## windows

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

