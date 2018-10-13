yum install -y nfs-utils;
systemctl enable rpcbind;
systemctl enable nfs;
systemctl start rpcbind;
systemctl start nfs;
echo "/data *(rw,fsid=0,sync,no_root_squash)" >> /etc/exports;
exportfs -rv;

