FROM alpine:3.8
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk add gcc g++ make libffi-dev openssl-dev
RUN VERSION="7.2" \
    && NEED_APK="curl php7>$VERSION php7-fpm>$VERSION" \
    && PHP_MODULES="php7-mongodb php7-xdebug php7-redis php7-gd php7-dom php7-json php7-pdo_mysql php7-session php7-zlib php7-curl php7-mbstring php7-wddx php7-xsl php7-mcrypt php7-openssl php7-soap php7-sockets php7-xmlrpc php7-pear php7-dev php7-phar php7-ctype php7-fileinfo php7-iconv php7-xmlreader php7-xmlwriter php7-zip php7-simplexml" \
    && apk --update add --no-cache $NEED_APK $PHP_MODULES

RUN php -v
#RUN pecl install mongodb \
#    && pecl install xdebug \
#    && pecl install redis 
ENV PHP_DIR /etc/php7
RUN apk add git

RUN curl -sS https://getcomposer.org/installer | php \
    && mv /build/composer.phar /usr/local/bin/composer

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
