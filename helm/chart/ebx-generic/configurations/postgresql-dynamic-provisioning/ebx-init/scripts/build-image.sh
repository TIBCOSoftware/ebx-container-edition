#!/usr/bin/env sh
#
# Copyright Cloud Software Group, Inc. 2023.
#
# This file builds the EBX-INIT image.
#
# Following environment variable must be defined:
# EBX_INIT_IMAGE: The name for the new image.
# see config file -> _ebx-build/ece/config/config-srv03.sh

# Stop on first error.
set -e

# Files names are relative to this script.
cd "$(dirname "$0")"

echo "Building image $1..."
docker build -t "$1" .
