#!/bin/bash

set -e

wget http://archive.cloudera.com/cm5/installer/latest/cloudera-manager-installer.bin

chmod u+x cloudera-manager-installer.bin

./cloudera-manager-installer.bin




#######################################
# 等待上面结束后进行操作
# http://Server host:7180
service cloudera-scm-server start

