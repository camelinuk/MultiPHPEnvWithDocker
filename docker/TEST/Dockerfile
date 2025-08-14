FROM alpine:edge
MAINTAINER James Chen <james.chen@lemon.cx>
WORKDIR /build


RUN apk update && apk add tzdata && apk add ca-certificates && rm -rf /var/cache/apk/* \
  mkdir /usr/local/share/ca-certificates/extra
