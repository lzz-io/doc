host='www.baidu.com'
#需要填写DNS服务器,否则可能获取不到
ip11=`nslookup $host 127.0.0.1 | awk 'NR==5 { print $3 }'`
#根据ping的结果截取IP地址，受系统设置的DNS限制
ip12=`ping $host -s1 -c1 | grep $host | head -n1 | cut -d'(' -f2 | cut -d')' -f1`


# 任意节点上执行 rabbitmqctl cluster_status 来查看集群状态
rabbitmqctl cluster_status 

rabbitmqctl stop_app && 
rabbitmqctl reset && 
rabbitmqctl join_cluster --ram rabbit@rabbitmq1 && 
rabbitmqctl start_app

rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster rabbit@rabbitmq1
rabbitmqctl start_app

rabbitmqctl join_cluster --ram rabbit@rabbitmq1 && 

rabbitmqctl stop_app && 
rabbitmqctl join_cluster --ram rabbit@rabbitmq1 && 
rabbitmqctl start_app
