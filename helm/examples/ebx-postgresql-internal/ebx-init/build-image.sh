#!/usr/bin/env bash
#
# Copyright Cloud Software Group, Inc. 2000-2022. All rights reserved.
#
# This file builds the EBX instance image.
#
# Following environment variable must be defined:
# EBX_INIT_IMAGE: The name for the new image.
# see config file -> _ebx-build/ece/config/config-srv03.sh

# Stop on first error.
set -e

# Files names are relative to this script.
cd "$(dirname "$0")"

if [[ -z "${EBX_INIT_IMAGE_NAME}" ]]; then
  echo "ERROR: Variable EBX_INIT_IMAGE_NAME must be defined." >&2
  exit 1
fi

echo "Building image ${EBX_INIT_IMAGE_NAME}..."
docker build -t "${EBX_INIT_IMAGE_NAME}" .
