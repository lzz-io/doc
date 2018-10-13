# lzz.io docker file

FROM php


LABEL author="lzz.io" \
		qq=1219331697 \
		url=lzz.io
		
ENV TZ="Asia/Shanghai"

COPY ./etc/php.ini /usr/local/etc/php/php.ini

COPY ./www/ /opt/www

EXPOSE     80

WORKDIR    /opt/www

#ENTRYPOINT ["php", "-S", "0.0.0.0:80"]
CMD ["php", "-S", "0.0.0.0:80"]