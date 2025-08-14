FROM alpine:3.8
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk update && apk add tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
#RUN pwd
#COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
#RUN update-ca-certificates
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone && date

RUN VERSION="5.6" \
    && NEED_APK="php5>$VERSION php5-fpm>$VERSION" \
    && PHP_MODULES="php5-gd php5-dom php5-json php5-pdo php5-pdo_mysql php5-xml php5-zlib php5-curl php5-wddx php5-xsl php5-phar php5-iconv php5-intl php5-mcrypt php5-soap php5-sockets php5-openssl php5-ctype" \
    && apk --update add --no-cache $NEED_APK $PHP_MODULES
#    && apk --update add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.4/main/ $NEED_APK $PHP_MODULES

ENV PHP_DIR /etc/php5
RUN ln -s /usr/bin/php5 /usr/bin/php
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

VOLUME ["/volume/config", "/volume/data", "/volume/log", "/var/log/php-fpm"]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN addgroup nginx \
    && adduser -D nginx -G nginx

EXPOSE 9000/tcp

CMD /usr/bin/php-fpm5 --nodaemonize
