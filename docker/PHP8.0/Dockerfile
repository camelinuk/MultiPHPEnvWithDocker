FROM alpine:edge
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk update && apk add tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
#RUN pwd
#COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
#RUN update-ca-certificates
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone && date


RUN VERSION="8.0" \
    && NEED_APK="curl php8>$VERSION php8-fpm>$VERSION" \
    && PHP_MODULES="php8-posix php8-calendar php8-pcntl php8-bcmath php8-mysqli php8-common php8-opcache php8-tokenizer php8-tokenizer php8-gd php8-dom php8-json php8-pdo php8-pdo_mysql php8-pdo_sqlite php8-sqlite3 php8-mysqlnd php8-mysqli php8-ctype php8-iconv php8-fileinfo php8-intl php8-exif php8-simplexml php8-session php8-zlib php8-curl php8-mbstring php8-openssl php8-soap php8-sockets php8-xml php8-xmlwriter php8-xmlreader php8-zip php8-xsl php8-pecl-redis php8-pecl-imagick php8-pecl-mongodb php8-pecl-xdebug php8-pecl-oauth php8-pecl-uuid php8-phar php8-tidy" \
    && apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/community $NEED_APK $PHP_MODULES

RUN php8 -v \
    && php8 -m
ENV PHP_DIR /etc/php8
RUN apk add git

#install download helpers
RUN apk add wget

RUN curl -sS https://getcomposer.org/installer | php8 \
    && mv /build/composer.phar /usr/local/bin/composer

RUN mkdir /volume \
    && mkdir /volume/log \
    && mkdir /volume/data \
    && mkdir /volume/config \
    && mkdir /var/log/php-fpm \
    && mkdir -p /usr/log/php-fpm \
    && mv $PHP_DIR/php.ini $PHP_DIR/php.ini.bak \
    && ln -s /volume/config/php.ini $PHP_DIR/php.ini \
    && mv $PHP_DIR/php-fpm.conf $PHP_DIR/php-fpm.conf.bak \
    && ln -s /volume/config/php-fpm.conf $PHP_DIR/php-fpm.conf

# install phpunit
RUN wget https://phar.phpunit.de/phpunit-9.phar -O /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

VOLUME ["/volume/config", "/volume/data", "/volume/log", "/var/log/php-fpm"]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN addgroup nginx \
    && adduser -D nginx -G nginx

EXPOSE 9000/tcp

CMD /usr/sbin/php-fpm7 --nodaemonize
