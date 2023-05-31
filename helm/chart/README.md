

# EBX generic chart

## Overview

This chart bootstraps an EBX deployment on a Kubernetes cluster using the Helm package 
manager.

This chart is a generic example, which means that it was made to work in most case.

This chart was tested with the [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) 
maintained by the Kubernetes community. 
This chart assumes it is already installed or you have a similar solution on your cluster.

**Note**: 
  TODO

## Prerequisites

* Kubernetes 1.23+, a working kubernetes cluster from a [certified K8s distro](https://www.cncf.io/certification/software-conformance/).
* Helm 3+
* EBX (Container Edition) image pushed on your docker registry

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
| `global.ebxImageRegistry`    | The Docker registry where we pull the EBX and the EBX-INIT images from.         | `""`         |
| `global.ebxImageRepository`  | The EBX image repository                                                        | `"ebx"`      |
| `global.ebxImageTag`         | The EBX image tag                                                               | `""`         |
| `global.imageRegistrySecret` | The secret that contains the credentials used to connect to the Docker registry | `""`         |
| `global.namespace`           | The namespace where EBX will be deployed                                        | `"ebx"`      |
| `global.hostname`            | The hostname of the kubernetes server host                                      | `""`         |
| `global.scheme`              | The scheme that define the protocol of the kubernetes server                    | `"https"`    |

----------

### Instance parameters

| Name                              | Description                                                                                                                                                                 | Value     |
|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `instance.ebxPrefix`              | The prefix name used for every kubernetes object of the instance (Pod, Service, Ingress...)                                                                                 | `""`      |
| `instance.ebxUser`                | The username used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_LOGIN`)                                                           | `"admin"` |
| `instance.ebxPassword`            | The password used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_PASSWORD`) <b><u>must be enclosed in single quotes<u><b>          | `''`      |
| `instance.cpu`                    | The cpu number allocate to the ebx container                                                                                                                                | `"2"`     |
| `instance.memory`                 | The ebx container memory limit                                                                                                                                              | `"2Gi"`   |
| `instance.storageClass`           | storageClass used to claim volumes                                                                                                                                          | `""`      |
| `instance.dataVolumeStorageClaim` | The amount of disk space of the PersistentVolume requested by the ebx instance to store it's data (this value must be greater than or equal to the dataVolumeStorage value) | `"10Gi"`  |
| `instance.logsVolumeStorageClaim` | The amount of disk space requested by the PersistentVolumeClaim for the data of the ebx instance                                                                            | `"2Gi"`   |

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
you'll have to uncomment them if you want to activate them.
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

**Note**: for ```database.type``` refer to 
[this documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md) 
to see the compatible databases and their associated values types for the chart.

#### SQL databases (Include Azure SQL Database)

| Name                              | Description                                                                        | Value                      |
|-----------------------------------|------------------------------------------------------------------------------------|----------------------------|
| `database.encrypt`                | A property for jdbc sql connection                                                 | `"true"`                   |
| `database.trustServerCertificate` | A property for jdbc sql connection                                                 | `"false"`                  |
| `database.hostNameInCertificate`  | The host name to be used to validate the SQL Server TLS/SSL certificate            | `"*.database.windows.net"` |
| `database.loginTimeout`           | The number of seconds the driver should wait before timing out a failed connection | `30`                       |

check the [official documentation](https://learn.microsoft.com/en-us/sql/connect/jdbc/setting-the-connection-properties?view=sql-server-ver16) 

**Note**: these values will only be used if ```database.type``` value equals to ```sqlserver``` or ```azure.sql```.

----------

## Installation examples

Here are some examples of installations commands for deploying ebx with different databases.

**Note**: Some jdbc drivers are not included in the original EBX image, please refer to the following
[documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md)
for more information.

### Deploy EBX with an embedded H2 database.

```
helm upgrade --debug production \
--install \
--set-string global.ebxImageRegistry=your.ebx.docker.registry \
--set-string global.ebxImageTag=6.1.0 \
--set-string global.hostname=k8s.host.example.com \
--set-string instance.ebxPrefix=production \
--set-string instance.ebxPassword='ebxPwD23!' \
--set-string database.name=ebx \
--set-string database.user=ebx \
--set-string database.pwd=ebx \
--set-string database.type=h2.standalone \
./ebx-generic-chart
```

### Deploy EBX with a Postgresql database.

```
helm upgrade --debug production \
--install \
--set-string global.ebxImageRegistry=ebx.docker.registry \
--set-string global.ebxImageTag=6.1.0 \
--set-string global.hostname=k8s.host.example.com \
--set-string instance.ebxPrefix=production \
--set-string instance.ebxPassword='ebxPwD23!' \
--set-string database.name=ebxDB \
--set-string database.user=ebxUsr \
--set-string database.pwd='?p433W0rd?' \
--set-string database.host=ebx-postgresql.example.com \
--set-string database.port=5432 \
--set-string database.type=postgresql \
./ebx-generic-chart
```

TODO : NOTE -> rappel sur les mots de passe sensible à la casse chez postgresql puis renvoie vers la doc

### Deploy EBX with an sql database.

```
helm upgrade --debug production \
--install \
--set-string global.ebxImageRegistry=your.ebx.docker.registry \
--set-string global.ebxImageTag=6.1.0 \
--set-string global.hostname=k8s.example.com \
--set-string instance.ebxPrefix=production \
--set-string instance.ebxPassword='ebxPwD23!' \
--set-string database.name=ebxDB \
--set-string database.user=ebxUsr \
--set-string database.pwd=ebxPwd \
--set-string database.host=ebx-mssql.example.com \
--set-string database.port=4875 \
--set-string database.type=sqlserver \
./ebx-chart
```

NOTE:
encryption is enable by default, you can disable it by adding this line to the above helm command:
--set-string database.encrypt=false \

check the database section in the values.yaml file of the ebx-generic-chart. TODO link

### Deploy EBX with an oracle database.

```
helm upgrade --debug production \
--install \
--set-string global.ebxImageRegistry=your.ebx.docker.registry \
--set-string global.ebxImageTag=6.1.0 \
--set-string global.hostname=k8s.host.example.com \
--set-string instance.ebxPrefix=production \
--set-string instance.ebxPassword='ebxPwD23!' \
--set-string database.name=ebxDB \
--set-string database.user=ebxUsr \
--set-string database.pwd='?p433W0rd?' \
--set-string database.host=ebx-oracle.example.com \
--set-string database.port=5120 \
--set-string database.type=oracle \
./ebx-generic-chart
```

### Deploy EBX with an Azure SQL database. TODO

```

```


### Deploy EBX with an SAP HANA database. TODO

```

```

## Customize and extend the chart
This chart provide a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software on kubernetes. 
It's suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case, 
in compliance with the Apache License 2.0. However, we recommend that you extend this chart, rather than modify it. 







           


