#!/usr/bin/env bash

cd `dirname $0`

IMAGE_NAME="lemoncx/redis-srv:6.2rc"

case "$1" in
    build)
        docker build --network=host -t $IMAGE_NAME .
        ;;

    push)
        docker push $IMAGE_NAME
        ;;
    *)
        echo $"Usage: $0 {build|push}"
        exit 1
esac
