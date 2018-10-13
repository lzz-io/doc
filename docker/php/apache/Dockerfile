# lzz.io docker file

FROM php:apache


LABEL author="lzz.io" \
		qq=1219331697 \
		url=lzz.io
		
ENV TZ="Asia/Shanghai"

COPY ./etc/php.ini /usr/local/etc/php/php.ini

COPY ./www/ /var/www/html
