


## Introduction

This chart bootstraps an EBX deployment on a Kubernetes cluster using the Helm package 
manager.

This chart was tested with the [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) 
maintained by the Kubernetes community. 
This chart assumes it is already installed or you have a similar solution on your cluster.

**Note**: 

## Prerequisites

* Kubernetes 1.23+, a working kubernetes cluster from a [certified K8s distro](https://www.cncf.io/certification/software-conformance/).
* Helm 3+
* EBX (Container Edition) image pushed on your docker registry
* PV provisioner support in the underlying infrastructure (StorageClass config)

## Installing the Chart

Before you begin be careful to these points: 
- set the ingress annotations according to the architecture of your cluster 
  (see annotations parameter in the [Ingress parameters](#Ingress-parameters) section).

To install the chart with the release name ```production``` in the namespace ```ebx``` (default value):

```
 helm upgrade --debug production \
 --install \
 --set-string global.namespace=ebx \
 --set-string global.ebxImageRegistry=<your.docker-registry.com> \
 --set-string global.ebxImageTag=<the EBX image tag> \
 --set-string global.hostname=<your.hostname.com> \
 --set-string instance.ebxPrefix=production \
 --set-string instance.ebxPassword=<'?Y0urP4ssWord!'> \
 --set-string database.name=<ebx db name> \
 --set-string database.user=<ebx db user> \
 --set-string database.pwd=<ebx db password> \
 --set-string database.host=<ebx db host> \
 --set-string database.port=<ebx db port> \
 --set-string database.type=<ebx db type> \
 ./ebx-generic-chart
```

## Uninstalling the Chart
To uninstall the chart with the release name ```production```:
```
helm delete production
```
----------

## Parameters

### Global parameters

| Name                         | Description                                                                     | Value        |
|------------------------------|---------------------------------------------------------------------------------|--------------|
| `global.ebxImagesRegistry`   | The Docker registry where we pull the EBX and the EBX-INIT images from.         | `""`         |
| `global.ebxImageRepository`  | The EBX image repository                                                        | `"ebx"`      |
| `global.ebxImageTag`         | The EBX image tag                                                               | `""`         |
| `global.imageRegistrySecret` | The secret that contains the credentials used to connect to the Docker registry | `""`         |
| `global.namespace`           | The namespace where EBX will be deployed                                        | `"ebx"`      |
| `global.hostname`            | The hostname of the kubernetes server host                                      | `""`         |
| `global.scheme`              | The scheme that define the protocol of the kubernetes server                    | `"https"`    |

----------

### Instance parameters

| Name                              | Description                                                                                                                                                                              | Value     |
|-----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `instance.ebxPrefix`              | The prefix name used for every kubernetes object deployed by the helm release (Pod, Service, Ingress...)                                                                                 | `""`      |
| `instance.ebxUser`                | The username used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_LOGIN`)                                                                        | `"admin"` |
| `instance.ebxPassword`            | The password used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_PASSWORD`) <b><u>must be enclosed in single quotes<u><b>                       | `''`      |
| `instance.cpu`                    | The cpu number allocate to the ebx container                                                                                                                                             | `"2"`     |
| `instance.memory`                 | The ebx container memory limit                                                                                                                                                           | `"2Gi"`   |
| `instance.storageClass`           | storageClass used to claim volumes                                                                                                                                                       | `""`      |
| `instance.dataVolumeStorageClaim` | The amount of disk space of the PersistentVolume requested by the ebx instance to store it's data (this value must be greater than or equal to the dataVolumeStorage value)              | `"10Gi"`  |
| `instance.logsVolumeStorageClaim` | The amount of disk space requested by the PersistentVolumeClaim for the data of the ebx instance                                                                                         | `"2Gi"`   |

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

**Note**: Annotations are provided as comments in the ```ingress.annotations``` section of the [values.yaml file](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/ebx-generic/ebx-generic-chart/values.yaml).
These are only examples of structure-based configurations, which means your structure may need other 
annotations.

Please refer to the 
[following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) 
to best meet your needs.

----------

### Database server parameters

| Name             | Description                           | Value   |
|------------------|---------------------------------------|---------|
| `database.name`  | The database server name              | `""`    |
| `database.user`  | The database server user              | `""`    |
| `database.pwd`   | The database server database password | `""`    |
| `database.host`  | The database server host              | `""`    |
| `database.port`  | The database server port              | `""`    |
| `database.type`  | The database server type              | `""`    |

**Note**: Refer to 
[this documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md) 
to see the compatible databases and their associated values types for the chart.

#### Microsoft Azure SQL database

| Name                              | Description | Value                      |
|-----------------------------------|-------------|----------------------------|
| `database.encrypt`                | TODO        | `"true"`                   |
| `database.trustServerCertificate` | TODO        | `"false"`                  |
| `database.hostNameInCertificate`  | TODO        | `"*.database.windows.net"` |

**Note**: these values will only be used if ```database.type``` value equals ```azure.sql```.

----------

## Customize and extend the chart
These recipes provide a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software. 
They are suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case, 
in compliance with the Apache License 2.0. However, we recommend that you extend these charts, rather than modify them. 







           


