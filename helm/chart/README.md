


## Introduction

This chart bootstraps an EBX deployment configured with a database on a Kubernetes cluster using the Helm package manager.

This chart assumes you have an ingress controller already install on your cluster.
If not you can check the following documentation to install it :
- [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) (maintained by the Kubernetes community)

## Prerequisites

* Kubernetes 1.23+
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

| Name                              | Description                                                                                                                                                                              | Value       |
|-----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| `instance.ebxPrefix`              | The prefix name used for every kubernetes object deployed by the helm release (Pod, Service, Ingress...)                                                                                 | `""`        |
| `instance.ebxUser`                | The username used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_LOGIN`)                                                                        | `"admin"`   |
| `instance.ebxPassword`            | The password used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_PASSWORD`) <b><u>must be enclosed in single quotes<u><b>                       | `''`        |
| `instance.cpu`                    | The cpu number allocate to the ebx container                                                                                                                                             | `"2"`       |
| `instance.memory`                 | The ebx container memory limit                                                                                                                                                           | `"2Gi"`     |
| `instance.storageClass`           | storageClass used to claim volumes                                                                                                                                                       | `"default"` |
| `instance.dataVolumeStorageClaim` | The amount of disk space of the PersistentVolume requested by the ebx instance to store it's data (this value must be greater than or equal to the dataVolumeStorage value)              | `"10Gi"`    |
| `instance.logsVolumeStorageClaim` | The amount of disk space requested by the PersistentVolumeClaim for the data of the ebx instance                                                                                         | `"2Gi"`     |

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

Please refer to the [following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) to best meet your needs.

----------

### Database server parameters

| Name             | Description                           | Value         |
|------------------|---------------------------------------|---------------|
| `database.name`  | The database server name              | `""`          |
| `database.user`  | The database server user              | `"postgres"`  |
| `database.pwd`   | The database server database password | `""`          |
| `database.host`  | The database server host              | `""`          |
| `database.port`  | The database server port              | `"5432"`      |
| `database.type`  | The database server type              | `""`          |

#### only for Microsoft Azure SQL database

| Name                              | Description | Value                      |
|-----------------------------------|-------------|----------------------------|
| `database.encrypt`                | TODO        | `"true"`                   |
| `database.trustServerCertificate` | TODO        | `"false"`                  |
| `database.hostNameInCertificate`  | TODO        | `"*.database.windows.net"` |

----------






           


