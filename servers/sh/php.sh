yum install -y libxml2-devel bzip2-devel libjpeg-devel libpng-devel libmcrypt-devel freetype-devel 

./configure --prefix=/opt/php --with-config-file-path=/opt/php/etc \
	--with-apxs2=/opt/apache2/bin/apxs \
	--with-mysql --with-mysqli --enable-pdo --with-pdo-mysql  \
	--enable-mbstring --with-mcrypt \
	--enable-exif --with-jpeg-dir --with-png-dir \
	--enable-xml \
	--enable-zip --with-bz2 --with-zlib-dir \
	--with-freetype-dir \
	--with-gd --enable-gd-native-ttf

make;
make install



cp php.ini-development /opt/php/etc/php.ini
date.timezone = Asia/Shanghai

LoadModule php5_module        modules/libphp5.so

<FilesMatch "\.ph(p[2-6]?|tml)$">
    SetHandler application/x-httpd-php
</FilesMatch>

<FilesMatch "\.phps$">
    SetHandler application/x-httpd-php-source
</FilesMatch>