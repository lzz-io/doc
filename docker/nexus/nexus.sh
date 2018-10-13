#! /bin/sh

yum update -y
yum install docker -y
systemctl enable docker
systemctl start docker

docker pull sonatype/nexus

mkdir -p /opt/nexus-data && chown -R 200 /opt/nexus-data
docker run -d --restart="always" -p 8081:8081 --name nexus -v /opt/nexus-data:/sonatype-work sonatype/nexus
