FROM alpine:edge
FROM php:8.4-fpm-alpine
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk update && apk add git wget tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
#RUN pwd
#COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
#RUN update-ca-certificates
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone && date

ENV PHP_V="php84"

RUN apk add --no-cache ${PHP_V} 
RUN VERSION="8.4" \
    && NEED_APK="curl ${PHP_V}>$VERSION ${PHP_V}-fpm>$VERSION" \
   && PHP_MODULES="${PHP_V}-common ${PHP_V}-gd ${PHP_V}-bcmath ${PHP_V}-dom ${PHP_V}-json ${PHP_V}-pdo ${PHP_V}-pdo_mysql ${PHP_V}-mysqli ${PHP_V}-pecl-imagick ${PHP_V}-mysqlnd ${PHP_V}-ctype ${PHP_V}-iconv ${PHP_V}-fileinfo ${PHP_V}-intl ${PHP_V}-simplexml ${PHP_V}-session ${PHP_V}-zlib ${PHP_V}-curl ${PHP_V}-mbstring ${PHP_V}-xsl ${PHP_V}-openssl ${PHP_V}-soap ${PHP_V}-sockets ${PHP_V}-xml ${PHP_V}-xmlwriter ${PHP_V}-xmlreader ${PHP_V}-zip ${PHP_V}-xsl ${PHP_V}-phar ${PHP_V}-pecl-redis ${PHP_V}-pecl-xdebug ${PHP_V}-pecl-uuid ${PHP_V}-posix ${PHP_V}-phar ${PHP_V}-sockets ${PHP_V}-litespeed ${PHP_V}-tokenizer ${PHP_V}-pecl-ssh2 ${PHP_V}-pecl-swoole ${PHP_V}-pecl-uploadprogress" \
    && apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/community $NEED_APK $PHP_MODULES

ENV PHP_DIR /etc
CMD ["ls","/usr/sbin"]
CMD ["php","-v"]
#RUN /usr/sbin/php-fpm -v
RUN php -v
RUN php -v \
    && php -m

RUN curl -sS https://getcomposer.org/installer | ${PHP_V} \
    && mv /build/composer.phar /usr/local/bin/composer

RUN mkdir /volume \
    && mkdir /volume/log \
    && mkdir /volume/data \
    && mkdir /volume/config \
    && mkdir /var/log/php-fpm \
    && mkdir -p /usr/log/php-fpm \
    #&& mv $PHP_DIR/php.ini $PHP_DIR/php.ini.bak \
    && ln -s /volume/config/php.ini $PHP_DIR/php.ini \
    #&& mv $PHP_DIR/php-fpm.conf $PHP_DIR/php-fpm.conf.bak \
    && ln -s /volume/config/php-fpm.conf $PHP_DIR/php-fpm.conf \
    && ln -s /etc/${PHP_V}/php-fpm.d $PHP_DIR/php-fpm.d

# install phpunit
RUN wget https://phar.phpunit.de/phpunit-9.phar -O /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

VOLUME ["/volume/config", "/volume/data", "/volume/log", "/var/log/php-fpm"]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN addgroup nginx \
    && adduser -D nginx -G nginx

EXPOSE 9000/tcp

CMD /usr/sbin/php-fpm84 --nodaemonize
