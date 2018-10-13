mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.5.jar grep input output 'dfs[a-z.]+'
cat output/*



apt-get install ssh


RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


ssh localhost


ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys


bin/hdfs namenode -format

sbin/start-dfs.sh

hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode

hadoop-daemon.sh --script hdfs start namenode
