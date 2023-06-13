#!/usr/bin/env sh
#
# Copyright Cloud Software Group, Inc. 2000-2023. All rights reserved.
#

# Stop on first error.
set -e

if [ -z "$1" ];then
  echo "ERROR: Incorrect syntax."
  echo "you should specify the EBX_INIT_IMAGE_NAME"
  echo "ex: ./build_and_push.sh <EBX_INIT_IMAGE_NAME> <DOCKER_REGISTRY>"
  exit 1
fi

if [ -z "$2" ];then
  echo "ERROR: Incorrect syntax."
    echo "you should specify the DOCKER_REGISTRY"
    echo "ex: ./build_and_push.sh <EBX_INIT_IMAGE_NAME> <DOCKER_REGISTRY>"
    exit 1
fi

cd scripts/

chmod +x build-image.sh
chmod +x push-image.sh

./build-image.sh $1
./push-image.sh $1 $2


# TODO test again