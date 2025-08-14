FROM alpine:3.15
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk update && apk add tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
#RUN pwd
#COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
#RUN update-ca-certificates
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone && date


RUN VERSION="7.4" \
    && NEED_APK="curl php7>$VERSION php7-fpm>$VERSION" \
    && PHP_MODULES="php7-posix php7-calendar php7-pcntl php7-bcmath php7-mysqli php7-imagick php7-common php7-opcache php7-tokenizer php7-tokenizer php7-gd php7-dom php7-json php7-pdo php7-pdo_mysql php7-pdo_sqlite php7-sqlite3 php7-mysqlnd php7-mysqli php7-ctype php7-iconv php7-fileinfo php7-intl php7-exif php7-simplexml php7-session php7-zlib php7-curl php7-mbstring php7-mcrypt php7-openssl php7-soap php7-sockets php7-xmlrpc php7-xml php7-xmlwriter php7-xmlreader php7-zip php7-xsl php7-igbinary php7-pecl-redis php7-pecl-imagick php7-pecl-mongodb php7-pecl-xdebug php7-pecl-oauth php7-pecl-uuid php7-phar php7-tidy" \
    && apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/community $NEED_APK $PHP_MODULES

RUN php7 -v \
    && php7 -m
ENV PHP_DIR /etc/php7
RUN apk add git

#install download helpers
RUN apk add wget

#RUN curl -sS https://getcomposer.org/installer | php7 \
#    && mv /build/composer.phar /usr/local/bin/composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    php composer-setup.php \
    php -r "unlink('composer-setup.php');"

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
