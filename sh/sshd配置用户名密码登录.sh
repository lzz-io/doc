# 编辑/etc/ssh/sshd_config，将PasswordAuthentication改为yes
cat /etc/ssh/sshd_config | grep PasswordAuthentication

vi /etc/ssh/sshd_config

# 重启sshd
systemctl restart sshd


# 修改 root 密码
passwd

# 修改普通用户密码
passwd <username>
