# EBX Postgres Dynamic Provisioning

## Overview

This sample is a Helm chart for EBX with dynamic provisioning of postgresql databases.

This chart is used to dynamically create a postgres database when an EBX instance is created.

Each time an EBX instance is created, the init container ([EBX-INIT](#EBX-INIT)) will create a database dedicated to 
this instance on a PostgreSQL server.

This file assumes you have an [Ingress controller](https://github.com/kubernetes/ingress-nginx) already install on your 
cluster and a Postgresql server (11 to 14.x) configured.

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
Also make sure you know how to back up and restore your data when using this method for other than testing purposes.

To install the chart with the release name ```production-postgres``` in the namespace ```ebx``` (default value):

```
 helm upgrade production-postgres \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=<your.ebx.image.location> \
 --set-string global.ebxInitImage=<your.ebx.init.image.location> \
 --set-string global.hostname=<your.hostname.com> \
 --set-string ebx.prefix=production-postgres \
 --set-string ebx.adminPassword=<'?Y0urP4ssWord!'> \
 --set-string ebx.databaseName=<ebx db name> \
 --set-string ebx.databaseUser=<ebx db user> \
 --set-string ebx.databasePwd=<ebx db password> \
 --set-string ebx.databaseHost=<ebx db host> \
 --set-string ebx.databasePort=<ebx db port> \
 --set-string ebx.databaseType=postgresql \
 --set-string postgresServer.database=<master db name> \
 --set-string postgresServer.user=<maste db user> \
 --set-string postgresServer.pwd=<maste db password> \
 ./ebx-chart
```

**Note**: PostgreSQL is a case-sensitive database by default.
Be careful when choosing a database name. TODO test and review

## Uninstalling the Chart
To uninstall the chart with the release name ```production-postgres```:
```
helm delete production-postgres
```

## Configuration

### Global configuration

| Name                         | Description                                                                                                 | Value        |
|------------------------------|-------------------------------------------------------------------------------------------------------------|--------------|
| `global.ebxImage`            | The ebx container edition image URL                                                                         | `""`         |
| `global.imageRegistrySecret` | The secret that contains the credentials used to connect to the registry that host the ebx image (Optional) | `""`         |
| `global.namespace`           | The namespace where EBX will be deployed                                                                    | `"ebx"`      |
| `global.hostname`            | The hostname of the kubernetes server host                                                                  | `""`         |
| `global.scheme`              | The scheme that define the protocol of the kubernetes server (Optional)                                     | `"https"`    |

----------

### EBX configuration

| Name                                 | Description                                                                                                                                                                                                                                                         | Value                      |
|--------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| `ebx.prefix`                         | The prefix name used for every kubernetes object of the instance (Pod, Service, Ingress...)                                                                                                                                                                         | `""`                       |
| `ebx.adminLogin`                     | The username used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_LOGIN`). Will be ignored if `ebx.flaDisabled`  value is not true or if repository is already initialized.                                                 | `"admin"`                  |
| `ebx.adminPassword`                  | The password used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_PASSWORD`) <b><u>must be enclosed in single quotes<u><b>. Will be ignored if `ebx.flaDisabled` value is not true or if repository is already initialized. | `''`                       |
| `ebx.isSecured`                      | If "true", the protocol "HTTPS" is assumed. If "false", the protocol "HTTP" is assumed (overrides ece environment variable : `EBX_IS_SECURED`)                                                                                                                      | `'true'`                   |
| `ebx.flaDisabled`                    | For security reasons, one might want to disable the first-launch assistant in all circumstances by setting `ebx.flaDisabled` value to true (overrides ece environment variable : `EBX_FLA_DISABLED`)  (Mandatory on first execution)                                | `'true'`                   |
| `ebx.restAuthenticationBasic`        | restAuthenticationBasic if set to true enable Basic authentication for REST services. (overrides ece environment variable : `EBX_REST_AUTHENTICATION_BASIC`)                                                                                                        | `'true'`                   |
| `ebx.cpu`                            | The cpu number allocate to the ebx container                                                                                                                                                                                                                        | `"2"`                      |
| `ebx.memory`                         | The ebx container memory limit                                                                                                                                                                                                                                      | `"2Gi"`                    |
| `ebx.storageClass`                   | storageClass used to claim volumes (will take default storageClass if no value is specified)                                                                                                                                                                        | `""`                       |
| `ebx.dataVolumeStorageClaim`         | The amount of disk space of the PersistentVolume requested by the ebx instance to store it's data                                                                                                                                                                   | `"10Gi"`                   |
| `ebx.logsVolumeStorageClaim`         | The amount of disk space requested by the PersistentVolumeClaim for the data of the ebx instance                                                                                                                                                                    | `"2Gi"`                    |
| `ebx.databaseName`                   | The ebx database server name                                                                                                                                                                                                                                        | `""`                       |
| `ebx.databaseUser`                   | The ebx database server user                                                                                                                                                                                                                                        | `""`                       |
| `ebx.databasePwd`                    | The ebx database server password                                                                                                                                                                                                                                    | `""`                       |
| `ebx.databaseHost`                   | The ebx database server host                                                                                                                                                                                                                                        | `""`                       |
| `ebx.databasePort`                   | The ebx database server port                                                                                                                                                                                                                                        | `""`                       |
| `ebx.databaseType`                   | The ebx database server type                                                                                                                                                                                                                                        | `""`                       |
| `ebx.databaseEncrypt`                | A property for jdbc sql connection (Optional)                                                                                                                                                                                                                       | `"true"`                   |
| `ebx.databaseTrustServerCertificate` | A property for jdbc sql connection (Optional)                                                                                                                                                                                                                       | `"false"`                  |
| `ebx.databaseHostNameInCertificate`  | A property for jdbc sql connection (Optional) - The host name to be used to validate the SQL Server TLS/SSL certificate                                                                                                                                             | `"*.database.windows.net"` |
| `ebx.databaseLoginTimeout`           | A property for jdbc sql connection (Optional) - The number of seconds the driver should wait before timing out a failed connection                                                                                                                                  | `"30"`                     |

**Notes**:
- If ```ebx.storageClass``` is not specified, the default storage class will be used for provisioning.
  Please see the [storageClass documentation](https://kubernetes.io/docs/concepts/storage/storage-classes/)
  and the [dynamic volume provisioning concept](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for
  further informations.
- For ```ebx.databaseType``` refer to
  [this documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md)
  to see the compatible databases and their associated values types for the chart.
- The ```EBX_FLA_DISABLED``` ebx image variable (set from the [deployment](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/ebx-generic/ebx-generic-chart/templates/deployment.yaml))
  is by default set to ```true``` and is not configurable from the values.yaml
  file. The reason for this is that if the repo has not yet been initialised, you must set its value to true in order to
  initialise variables ```ebx.adminLogin``` and ```ebx.adminPassword```. If the repo is already initialised, these  values
  defined via the Helm command will be ignored and will retain the values set when the repo was initialised.
- Every jdbc sql property will only be used if ```ebx.databaseType``` value equals to ```sqlserver``` or ```azure.sql```.
  check the [official documentation](https://learn.microsoft.com/en-us/sql/connect/jdbc/setting-the-connection-properties?view=sql-server-ver16)
  for information about to setting the sql connection properties.

TODO pch review

----------

### Ingress configuration

| Name                      | Description                                                                                                                                                                                                                               | Value      |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|
| `ingress.className`       | className is the name of the chosen ingress-controller                                                                                                                                                                                    | `"nginx"`  |
| `ingress.tlsSecret`       | tlsSecret that contains the self-signed certificate and private key (Optional)                                                                                                                                                            | `""`       | 
| `ingress.hostRuleDefined` | hostRuleDefined modify the syntax of the ingress resource according to this value. If set to true, an host must be defined                                                                                                                | `"true"`   |
| `ingress.annotations`     | annotations to configure the ingress resource                                                                                                                                                                                             | `""`       |
| `ingress.pathRegex`       | pathRegex will complete the path ingress path field. For example with the default value, the final path will be of the form ```/{{ .Values.ebx.prefix}}/ebx.*``` (This value may change depending on the type of the ingress controller.) | `".*"`     |
| `ingress.pathType`        | pathType is pathType of the ingress                                                                                                                                                                                                       | `"Prefix"` |


**Note**:
- Use the [ingress-annotations-values.yaml](https://github.com/tibco/ebx-container-edition/tree/main/helm/chart/ebx-generic/ingress-annotations-values.yaml)
  file to add annotations for the ```ingress.annotations``` section. Please refer to the
  [following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/)
  to best meet your needs.

----------

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
is provided to help you to build and push the ebx-init image.

**Note**: The script 
[set-up-database.sh](https://github.com/tibco/ebx-container-edition/blob/main/helm/examples/ebx-postgresql-internal/ebx-init/scripts/set-up-database.sh) need to be updated to be compatible with postgresql 15.





           


