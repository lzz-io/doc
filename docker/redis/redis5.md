# redis5

## redis.conf

lfu内存淘汰算法

```properties
maxmemory-policy allkeys-lfu
lfu-log-factor 10
lfu-decay-time 1

#由于redis执行很快，密码有被暴力破解的可能，最好的办法是关闭外网访问、更改端口、启用ssl。
# requirepass 123
# masterauth 123

```

动态配置

```sh
# 设置密码
# CONFIG SET requirepass 123
# slave设置密码
# CONFIG SET masterauth 123

# save
# CONFIG REWRITE

# 登录
# redis-cli -a 123
#or
# redis-cli
# auth 123

```



## sentinel

```sh
cat sentinel.conf |grep -v "#" | grep -v "^$" > 26379.conf
```

**sentinel.conf**

```properties
sentinel monitor mymaster 127.0.0.1 6379 2
sentinel down-after-milliseconds mymaster 60000
sentinel failover-timeout mymaster 180000
sentinel parallel-syncs mymaster 1

# redis-server密码
# sentinel auth-pass mymaster 123
```

`sentinel monitor`语句参数的含义如下：

```properties
sentinel monitor <master-group-name> <ip> <port> <quorum>
```

quorum:半数以上，如节点3，3/2+1=2，这里指的是sentinel server的数量。



**常用命令**

```sh
# 强制故障转移
sentinel failover mymaster

SENTINEL get-master-addr-by-name mymaster
# 返回给定名字的主服务器的 IP 地址和端口号。 如果这个主服务器正在执行故障转移操作， 或者针对这个主服务器的故障转移操作已经完成， 那么这个命令返回新的主服务器的 IP 地址和端口号。

```



### 集群配置

redis-7000.conf

```properties
port 7000
daemonize yes
bind 0.0.0.0
dir /opt/redis/7000/
pidfile /var/run/redis_7000.pid
cluster-enabled yes
cluster-config-file nodes7000.conf
cluster-node-timeout 15000
appendonly yes
# 日志名称。空字符串表示标准输出。注意如果redis配置为后台进程，标准输出中信息会发送到/dev/null
logfile "/opt/redis/redis-server.log"

# 重要参数，生成环境高可用。
# 当cluster-require-full-coverage为no时，表示当负责一个插槽的主库下线且没有相应的从库进行故障恢复时，集群仍然可用。 默认 yes。
cluster-require-full-coverage no

# 内存淘汰算法
maxmemory-policy allkeys-lfu
lfu-log-factor 10
lfu-decay-time 1
```



```sh
redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 \
127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 \
--cluster-replicas 1
```



