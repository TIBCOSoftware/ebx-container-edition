# EBX-INIT

## Overview

This bundle contains the files needed to build and push the EBX-INIT image.

## How to build and push the EBX-INIT image

Open a Shell environment and execute the following script.

```
./build_and_push_image.sh <EBX_INIT_IMAGE_NAME> <YOUR_DOCKER_REGISTRY>
```

**Note**:

- You might need to add execution rights to enable execution. `chmod +x build_and_push_image.sh`
- `EBX_INIT_IMAGE_NAME` is made up of the name + the tag. ex: `ebx-init:1.0`
