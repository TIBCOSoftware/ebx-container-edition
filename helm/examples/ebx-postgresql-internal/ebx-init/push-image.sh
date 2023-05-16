#!/usr/bin/env bash
#
# Copyright Cloud Software Group, Inc. 2000-2022. All rights reserved.
#
# Push the Docker ebx-init image.

# Stop on first error.
set -e

docker tag "${EBX_INIT_IMAGE_NAME}" "${EBX_INIT_IMAGE}"
docker push "${EBX_INIT_IMAGE}"

# Remove image from host
docker rmi -f "${EBX_INIT_IMAGE_NAME}" "${EBX_INIT_IMAGE}"