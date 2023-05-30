# EBX-INIT 

## Overview

This bundle contains the files needed to build and push the EBX-INIT image.

## How to build and push the EBX-INIT image

Open a Shell environment and execute the following script.

``` 
./build_and_push_image.sh <EBX_INIT_IMAGE_NAME> <DOCKER_REGISTRY> 
```

Note : You may need to add execution right to be able to execute the script.

```
chmod +x build_and_push_image.sh
```

### Parameters

- ```EBX_INIT_IMAGE_NAME``` is the name of the ebx-init image.
the default value of the ebx-init image tag is latest.
You can change it by adding ```:your-tag``` at the end of the image name.

    ex : ```ebx-init-image-name-test:1.0```


- ```DOCKER_REGISTRY``` is the docker registry url where the ebx-init image will be pushed.