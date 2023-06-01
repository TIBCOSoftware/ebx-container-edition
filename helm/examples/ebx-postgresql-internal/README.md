
## Overview

This chart bootstraps an EBX deployment configured with a Postgresql server already install on the Kubernetes 
cluster.

This chart allows to create a database dynamically when an EBX instance is created and to allocate it to the instance. 

This file assumes you have an [Ingress controller](https://github.com/kubernetes/ingress-nginx) already install on your 
cluster and a Postgresql server (11 to 14.x) configured.

--- 
TODO choose NOTE

**Note**: Using the PostgreSQL database like this is not recommended for production use. Make sure you know how to back 
up and restore your data when using this chart for other than testing purposes.

**Note**: If you decided to install your PostgreSQL server on the same cluster, make sure you know how to back
up and restore your data when using this chart for other than testing purposes.

is not recommended for production use? TODO

--- 

## Prerequisites

* [Kubernetes](https://kubernetes.io/) 1.23+
* [Helm](https://helm.sh/) 3+
* Both EBX (Container Edition) and [EBX-INIT](#EBX-INIT) images pushed on your docker registry
* [Docker](https://www.docker.com/) 20.x for building the EBX-INIT container images.

## Installing the Chart

Before you begin be careful to set the ingress annotations according to the architecture of your cluster 
  (see annotations parameter in the [Ingress parameters](#Ingress-parameters) section).

**Note**: If the PostgreSql server is installed on the same cluster, be careful to configure the server so that it can 
access the namespace in which you want to install the Release EBX.
Otherwise, you can install ebx in the same namespace as your default postgresql server to avoid this problem.

To install the chart with the release name ```production``` in the namespace ```ebx``` (default value):

```
 helm upgrade --debug production \
 --install \
 --set-string global.ebxImageRegistry=<your.docker-registry.com> \
 --set-string global.ebxImageTag=<the EBX image tag> \
 --set-string global.ebxInitImageRegistry=<your.docker-registry.com> \
 --set-string global.ebxInitImageTag=<the EBX-INIT image tag> \
 --set-string global.hostname=<your.hostname.com> \
 --set-string instance.ebxPrefix=production \
 --set-string instance.ebxPassword=<'?Y0urP4ssWord!'> \
 --set-string database.name=<ebx db name> \
 --set-string database.user=<ebx db user> \
 --set-string database.pwd=<ebx db password> \
 --set-string database.host=<ebx db host> \
 --set-string database.port=5432 \
 --set-string database.type=postgresql \
 --set-string postgresServer.name=<postgresql server master db name> \
 --set-string postgresServer.user=<postgresql server master db user> \
 --set-string postgresServer.pwd=<postgresql server master db password> \
 ./ebx-chart
 
```

## Uninstalling the Chart
To uninstall the chart with the release name ```production```:
```
helm delete production
```

## Parameters

### Global parameters 

TODO REVIEW DOCKER PART 

| Name                            | Description                                                                     | Value        |
|---------------------------------|---------------------------------------------------------------------------------|--------------|
| `global.ebxImagesRegistry`      | The Docker registry where we pull the EBX and the EBX-INIT images from.         | `""`         |
| `global.ebxImageRepository`     | The EBX image repository                                                        | `"ebx"`      |
| `global.ebxImageTag`            | The EBX image tag                                                               | `""`         |
| `global.ebxInitImageRepository` | The EBX-INIT image repository                                                   | `"ebx-init"` |
| `global.ebxInitImageTag`        | The EBX-INIT image tag                                                          | `""`         |
| `global.imageRegistrySecret`    | The secret that contains the credentials used to connect to the Docker registry | `""`         |
| `global.namespace`              | The namespace where EBX will be deployed                                        | `"ebx"`      |
| `global.hostname`               | The hostname of the kubernetes server host                                      | `""`         |
| `global.scheme`                 | The scheme that define the protocol of the kubernetes server                    | `"https"`    |

----------

### Instance parameters

| Name                              | Description                                                                                                                                                                                                      | Value     |
|-----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `instance.ebxPrefix`              | The prefix name used for every kubernetes object deployed by the helm release (Pod, Service, Ingress...)                                                                                                         | `""`      |
| `instance.ebxUser`                | The username used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_LOGIN`)                                                                                                | `"admin"` |
| `instance.ebxPassword`            | The password used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_PASSWORD`) <b><u>must be enclosed in single quotes<u><b>    (TODO à mettre pour tous ou pour personne) | `''`      |
| `instance.cpu`                    | The cpu number allocate to the ebx container                                                                                                                                                                     | `"2"`     |
| `instance.memory`                 | The ebx container memory limit                                                                                                                                                                                   | `"2Gi"`   |
| `instance.storageClass`           | storageClass used to claim volumes                                                                                                                                                                               | `""`      |
| `instance.dataVolumeStorageClaim` | The amount of disk space of the PersistentVolume requested by the ebx instance to store it's data (this value must be greater than or equal to the dataVolumeStorage value)                                      | `"10Gi"`  |
| `instance.logsVolumeStorageClaim` | The amount of disk space requested by the PersistentVolumeClaim for the data of the ebx instance                                                                                                                 | `"2Gi"`   |

**Note**: If ```instance.storageClass``` is not specified, the default storage class will be used for provisioning.
Check the [storageClass documentation](https://kubernetes.io/blog/2017/03/dynamic-provisioning-and-storage-classes-kubernetes/) for further informations.

----------

### Ingress parameters

| Name                      | Description                                                                                                       | Value     |
|---------------------------|-------------------------------------------------------------------------------------------------------------------|-----------|
| `ingress.className`       | className is the name of the chosen ingress-controller                                                            | `"nginx"` |
| `ingress.tlsSecret`       | tlsSecret that contains the self-signed certificate and private key                                               | `""`      | 
| `ingress.hostRuleDefined` | hostRuleDefined modify the syntax of the ingress according to this value. If set to true, an host must be defined | `"true"`  |
| `ingress.annotations`     | annotations to configure the ingress resource                                                                     | `""`      |

Annotations are provided as comments in the ```ingress.annotations``` section of the values.yaml file.
These are only examples of structure-based configurations, which means your structure may need other
annotations.

**Note**: Please refer to the 
[following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) to 
best meet your needs.

----------

### Database server parameters

| Name             | Description                           | Value          |
|------------------|---------------------------------------|----------------|
| `database.name`  | The database server name              | `""`           |
| `database.user`  | The database server user              | `"postgres"`   |
| `database.pwd`   | The database server database password | `""`           |
| `database.host`  | The database server host              | `""`           |
| `database.port`  | The database server port              | `"5432"`       |
| `database.type`  | The database server type              | `"postgresql"` |


### Postgresql server parameters

| Name                    | Description                                  | Value        |
|-------------------------|----------------------------------------------|--------------|
| `postgresServer.name`   | The master database server name              | `""`         |
| `postgresServer.user`   | The master database server user              | `"postgres"` |
| `postgresServer.pwd`    | The master database server database password | `""`         |

## EBX-INIT

The ebx-init image is made to initialize a postgresql database for an EBX instance. 
it's mounted in the init-container of the deployment.

This image is based on an ```alpine:3.14.3``` and contains:
- the postgresql-client
- bash
- the set-up-database.sh script

A [bundle](https://github.com/tibco/ebx-container-edition/tree/main/helm/examples/ebx-postgresql-internal/ebx-init) 
is provided to allow you to build and push the ebx-init image.

**Note**: The script 
[set-up-database.sh](https://github.com/tibco/ebx-container-edition/blob/main/helm/examples/ebx-postgresql-internal/ebx-init/scripts/set-up-database.sh) need to be updated to be compatible with postgresql 15.





           


