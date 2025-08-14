FROM alpine:3.6
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk update && apk add tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
#RUN pwd
#COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
#RUN update-ca-certificates
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone && date

RUN VERSION="7.1" \
    && NEED_APK="php7>$VERSION php7-fpm>$VERSION" \
    && PHP_MODULES="php7-opcache curl php7-ftp php7-bz2 php7-calendar php7-exif php7-fileinfo php7-bcmath php7-gd php7-gettext php7-imagick php7-memcached php7-tidy php7-dom php7-json php7-pdo php7-pdo_mysql php7-mysqli php7-simplexml php7-session php7-zlib php7-curl php7-mbstring php7-wddx php7-xsl php7-mcrypt php7-openssl php7-soap php7-tokenizer php7-sockets php7-xmlrpc php7-xml php7-xmlwriter php7-pear php7-dev php7-phar php7-ctype php7-iconv php7-xmlreader php7-zip" \
    && apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/v3.5/community $NEED_APK $PHP_MODULES
#    && apk --update add --no-cache $NEED_APK $PHP_MODULES

ENV PHP_DIR /etc/php7
#RUN ln -s /usr/bin/php7 /usr/bin/php
RUN php -v


RUN mkdir /volume \
    && mkdir /volume/log \
    && mkdir /volume/data \
    && mkdir /volume/config \
    && mkdir /var/log/php-fpm \
    && mv $PHP_DIR/php.ini $PHP_DIR/php.ini.bak \
    && ln -s /volume/config/php.ini $PHP_DIR/php.ini \
    && mv $PHP_DIR/php-fpm.conf $PHP_DIR/php-fpm.conf.bak \
    && ln -s /volume/config/php-fpm.conf $PHP_DIR/php-fpm.conf

VOLUME ["/volume/config", "/volume/data", "/volume/log","/var/log/php-fpm"]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN addgroup nginx \
    && adduser -D nginx -G nginx

EXPOSE 9000/tcp

CMD /usr/sbin/php-fpm7 --nodaemonize
