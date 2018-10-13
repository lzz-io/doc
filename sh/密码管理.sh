# 修改密码命令passwd
passwd

# 使用useradd命令增加时，还需使用passwd命令为每一位新增加的用户设置口令；

# 用户以后还可以随时用passwd命令改变自己的口令。
# 该命令的一般格式为： passwd [用户名] 其中用户名为需要修改口令的用户名。

# 只有超级用户可以使用“passwd 用户名”修改其他用户的口令，普通用户只能用不带参数的passwd命令修改自己的口令。
# 例如：
# # passwd root
# New UNIX password:
# Retype new UNIX password:
# passwd: all authentication tokens updated successfully
# #
# 输入正确后，这个新口令被加密并放入/etc/shdow文件。