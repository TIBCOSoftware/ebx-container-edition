#!/usr/bin/env sh
#
# Copyright Cloud Software Group, Inc. 2000-2023. All rights reserved.
#
# This file push the EBX-INIT image on the desired Docker registry.

# Stop on first error.
set -e

EBX_INIT_IMAGE="$2/$1"

echo "pushing image ${EBX_INIT_IMAGE}..."

docker tag "$1" "${EBX_INIT_IMAGE}"

echo "The ebx-init image will be push the following location ${EBX_INIT_IMAGE}"

docker push "${EBX_INIT_IMAGE}"

# Remove image from host
docker rmi -f "$1" "${EBX_INIT_IMAGE}"