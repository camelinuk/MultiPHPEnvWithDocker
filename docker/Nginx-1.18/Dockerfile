FROM alpine:3.12
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build

RUN apk update && apk add tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
#RUN pwd
#COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt
#RUN update-ca-certificates
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone && date

RUN VERSION="1.18" \
    && NEED_APK="nginx>$VERSION nginx-mod-http-upload-progress nginx-mod-http-cache-purge" \
    && apk --update add openssl openssl-libs-static $NEED_APK

RUN mkdir /volume \
    && mkdir /volume/log \
    && mkdir /volume/data \
    && mkdir /volume/config \
    && mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak \
    && ln -s /volume/config/nginx.conf /etc/nginx/nginx.conf

VOLUME ["/volume/config", "/volume/data", "/volume/log"]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD /usr/sbin/nginx -g "daemon off;"
