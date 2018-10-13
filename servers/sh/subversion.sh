yum install -y sqlite-devel

make clean

./configure --prefix=/opt/dev/subversion \
	--with-apxs=/opt/apache2/bin/apxs --with-apache-libexecdir=/opt/apache2/modules \
	--with-apr=/opt/lib/apr --with-apr-util=/opt/lib/apr \
	--with-ssl

make;make install

###############################################################################
# svn apache module
###############################################################################
LoadModule dav_module modules/mod_dav.so
LoadModule dav_svn_module modules/mod_dav_svn.so
LoadModule authz_svn_module modules/mod_authz_svn.so

# 禁制访问.svn目录
<Directory ~ "\.svn">
	Order allow,deny
	Deny from all
</Directory>

mkdir -p /opt/dev/subversion/data/repositories
svnadmin create /opt/dev/subversion/data/repositories/lzz

#htpasswd -c -b -m /opt/dev/subversion/data/conf/passwd lzz admin888
htpasswd -b -m /opt/dev/subversion/data/conf/passwd lzz admin888

	<Location /svn>
		DAV svn
		SVNListParentPath on
		SVNParentPath /opt/dev/subversion/data/repositories
		AuthType Basic
		AuthName "Lzz's Subversion repository"
		AuthUserFile /opt/dev/subversion/data/conf/passwd
		AuthzSVNAccessFile /opt/dev/subversion/data/conf/authz
		Require valid-user
	</Location>

#
#    创建svn用户
# htpasswd -c -b -m /opt/dev/subversion/data/conf/passwd lzz admin888
#
#    添加svn用户
# htpasswd -b -m /opt/dev/subversion/data/conf/passwd lzz1 admin888
#
#     删除用户
# htpasswd -D /svn/repot/conf/passwd rouser
#
#     重置密码，先使用crypt加密，后使用MD5加密
# htpasswd -b /svn/repot/conf/passwd admin 654321
# htpasswd -b -m /svn/repot/conf/passwd admin 111111
#
#		http://man.chinaunix.net/newsoft/Apache2.2_chinese_manual/programs/htpasswd.html
#       使用htpasswd命令创建用户配置文件
#        -c            第一次创建用户的时候，同步创建用户配置文件（仅第一次）
#        -b            在htpasswd命令中明文配置密码
#        -m            使用MD5对密码进行加密
#        /svn/repot/conf/passwd    用户配置文件位置，文件名和存放目录没有要求
#        admin         用户名
#        123456        admin密码，因为前面使用了 -b 选项，所以必须在后面加上密码
#
#        创建第二个用户的时候就不需要 -c 选项了
#        不指定加密选项则在Linux上默认使用 -d 选项，crypt加密
#        不使用 -b 选项，则会提示你输入两次没有回显的密码，两次密码必须一致
#


DAV svn
告诉Apache哪个模块负责服务像那样的URL－－在这里就是Subversion模块

SVNListParentPath on
在Subversion 1.3及更高版本中，这个指示器使得Subversion列出由SVNParentPath指定的目录下所有的版本库

SVNParentPath /opt/dev/subversion/data/repositories
告诉Subversion在目录D:\SVN下寻找版本库
以上介绍的配置为Apache多库方式，即一个location可以同时为多个版本库服务，
还有一种配置方式为Apache单库方式，即一个location只能为一个版本库服务，
配置时只要将上面的 SVNParentPath 改为 SVNPath ，同时将后面的路径由版本库的父目录改为版本库的目录

AuthType Basic
启用基本的验证，比如用户名/密码对

AuthName "Subversion repositories"
当一个验证对话框弹出时，告诉用户这个验证是用来做什么的

AuthUserFile /opt/dev/subversion/data/conf/passwd
指定 /opt/dev/subversion/data/conf/passwd 用为密码文件用来验证用户的用户名及密码

AuthzSVNAccessFile /opt/dev/subversion/data/conf/authz
指定 /opt/dev/subversion/data/conf/authz 来限定各个用户或组在版本库中目录的访问权限

Require valid-user
限定用户只有输入正确的用户名及密码后才能访问这个路径

