#!/usr/bin/env bash

cd `dirname $0`

IMAGE_NAME="lemoncx/php:8.4"

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
