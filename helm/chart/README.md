# EBX generic

## Overview

This sample is a Helm chart for EBX.

This chart is a generic example, that should work on most Kubernetes cluster. 

This chart was tested with the [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) 
maintained by the Kubernetes community. 
This chart assumes it is already installed on your cluster.

## Prerequisites

* Kubernetes v1.23+, a working Kubernetes cluster from a [certified Kubernetes Software](https://www.cncf.io/certification/software-conformance/) 
except some particular version such as [Red Hat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift).
* Helm v3+
* EBX (Container Edition) image pushed on your docker registry

## Installing the Chart

Before installing the chart, you may need to adjust your ingress annotations according to your needs.
To do so, you first have to add the annotations that suit your needs in the 
[ingress-annotations-values.yaml](https://github.com/tibco/ebx-container-edition/tree/main/helm/chart/ebx-generic/ingress-annotations-values.yaml) 
file as explain here:

```
ingress:
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/service-upstream: "true"
    nginx.ingress.kubernetes.io/proxy-ssl-server-name: "ssl-server-name-test"
    
```
**Note**:
- These annotations are only examples. For details, please see the [Ingress-Nginx Controller annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) 
section.
- Please see the [ingress configuration section](#Ingress-configuration) for more information about how to configure
    the ingress resource.

### Install command

To install the chart with the release name `ebx-chart` in the namespace ```ebx```:

```
helm upgrade ebx-chart \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=<your.image.location> \
 --set-string global.hostname=<your.hostname.com> \
 --set-string ebx.prefix=s1 \
 --set-string ebx.adminPassword=<'?Y0urP4ssWord!'> \
 --set-string ebx.databaseName=<ebx db name> \
 --set-string ebx.databaseUser=<ebx db user> \
 --set-string ebx.databasePwd=<'ebx db password'> \
 --set-string ebx.databaseHost=<ebx db host> \
 --set-string ebx.databasePort=<ebx db port> \
 --set-string ebx.databaseType=<ebx db type> \
 ./ebx-generic-chart
```

## Uninstalling the Chart
To uninstall the chart with the release name `ebx-chart`:
```
helm delete ebx-chart
```
----------

## Configuration

### Global configuration

| Name                         | Description                                                                                                 | Value      |
|------------------------------|-------------------------------------------------------------------------------------------------------------|------------|
| `global.ebxImage`            | The ebx container edition image URL                                                                         | `""`       |
| `global.imageRegistrySecret` | The secret that contains the credentials used to connect to the registry that host the ebx image (Optional) | `""`       |
| `global.namespace`           | The namespace where EBX will be deployed                                                                    | `"ebx"`    |
| `global.hostname`            | The hostname used to connect to EBX                                                                         | `""`       |
| `global.scheme`              | The scheme that defines the protocol used to connect to EBX (Optional)                                      | `"https"`  |

----------

### EBX configuration

| Name                                 | Description                                                                                                                                                                                                                                                         | Value                      |
|--------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| `ebx.prefix`                         | The prefix name used for every Kubernetes object of the instance (Pod, Service, Ingress...)                                                                                                                                                                         | `""`                       |
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
| `ebx.databaseLoginTimeout`           | A property for jdbc sql connection (Optional) - The number of seconds the driver should wait before timing out a failed connection.                                                                                                                                 | `"30"`                     |

**Notes**: 
- If ```ebx.storageClass``` is not specified, the default storage class will be used for provisioning.
Please see the [storageClass documentation](https://kubernetes.io/docs/concepts/storage/storage-classes/) 
and the [dynamic volume provisioning concept](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for 
further information.
- For ```ebx.databaseType``` refer to
[this documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md)
to see the compatible databases and their associated values types for the chart.
- The ```EBX_FLA_DISABLED``` ebx image variable (set from the [deployment](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/ebx-generic/ebx-generic-chart/templates/deployment.yaml)) 
is by default set to ```true``` and is not configurable from the values.yaml 
file. The reason for this is that if the repo has not yet been initialized, you must set its value to true in order to 
initialize variables ```ebx.adminLogin``` and ```ebx.adminPassword```. If the repo is already initialised, these  values 
defined via the Helm command will be ignored and will retain the values set when the repo was initialised.
- Every jdbc sql connection property will only be used if ```ebx.databaseType``` value equals to ```sqlserver``` or ```azure.sql```.
  check the [official documentation](https://learn.microsoft.com/en-us/sql/connect/jdbc/setting-the-connection-properties?view=sql-server-ver16)
  for information about to setting the sql connection properties.

----------

### Ingress configuration

| Name                      | Description                                                                                                                                                                                                                               | Value      |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|
| `ingress.className`       | className is the name of the chosen ingress-controller                                                                                                                                                                                    | `"nginx"`  |
| `ingress.tlsSecret`       | tlsSecret that contains the self-signed certificate and private key (Optional)                                                                                                                                                            | `""`       | 
| `ingress.hostRuleDefined` | hostRuleDefined modify the syntax of the ingress resource according to this value. If set to true, a host must be defined.                                                                                                                | `"true"`   |
| `ingress.annotations`     | annotations to configure the ingress resource                                                                                                                                                                                             | `""`       |
| `ingress.pathRegex`       | pathRegex will complete the path ingress path field. For example with the default value, the final path will be of the form ```/{{ .Values.ebx.prefix}}/ebx.*``` (This value may change depending on the type of the ingress controller.) | `".*"`     |
| `ingress.pathType`        | pathType is pathType of the ingress                                                                                                                                                                                                       | `"Prefix"` |


**Note**:
- Use the [ingress-annotations-values.yaml](https://github.com/tibco/ebx-container-edition/tree/main/helm/chart/ebx-generic/ingress-annotations-values.yaml) 
file to add annotations for the ```ingress.annotations``` section. Please refer to the 
[following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) 
to best meet your needs.

----------

## Installation examples

Here are some examples of installations commands for deploying ebx with different databases.

**Note**: Some jdbc drivers are not included in the original EBX image, please refer to the following
[documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md)
for more information.

### Deploy EBX with an embedded H2 database.

```
helm upgrade ebx-chart \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=docker.registry.com:1234/ebx:6.1.0 \
 --set-string global.hostname=ebx.hostname-example.com \
 --set-string ebx.prefix=s1 \
 --set-string ebx.adminPassword='?Y0urP4ssWord!' \
 --set-string ebx.databaseName=ebxDb \
 --set-string ebx.databaseUser=abxDbUser \
 --set-string ebx.databasePwd='+Jjf6frs7?' \
 --set-string ebx.databasePort=7634 \
 --set-string ebx.databaseType=h2.standalone \
 ./ebx-generic-chart
```

**Note**: 
No need to enter value ```ebx.databaseHost``` for h2 embedded database.

TODO Please check that for an embedded H2 database,databaseUser, databasePwd and databasePort need to be filled in.

### Deploy EBX with a PostgreSQL database.

```
helm upgrade ebx-chart \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=docker.registry.com:1234/ebx:6.1.0 \
 --set-string global.hostname=ebx.hostname-example.com \
 --set-string ebx.prefix=s1 \
 --set-string ebx.adminPassword='?Y0urP4ssWord!' \
 --set-string ebx.databaseName=ebxDb \
 --set-string ebx.databaseUser=abxDbUser \
 --set-string ebx.databasePwd='+Jjf6frs7?' \
 --set-string ebx.databaseHost=postgresql.db-host.com \
 --set-string ebx.databasePort=5432 \
 --set-string ebx.databaseType=postgresql \
 ./ebx-generic-chart
```


### Deploy EBX with an SQL database.

```
helm upgrade ebx-chart \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=docker.registry.com:1234/ebx:6.1.0 \
 --set-string global.hostname=ebx.hostname-example.com \
 --set-string ebx.prefix=s1 \
 --set-string ebx.adminPassword='?Y0urP4ssWord!' \
 --set-string ebx.databaseName=ebxDb \
 --set-string ebx.databaseUser=abxDbUser \
 --set-string ebx.databasePwd='+Jjf6frs7?' \
 --set-string ebx.databaseHost=sqlserver.db-host.com \
 --set-string ebx.databasePort=1245 \
 --set-string ebx.databaseType=sqlserver \
 ./ebx-generic-chart
```

**Note**:
You can configure the connection settings by overwriting the jdbc sql properties present at the end of the 
[EBX configuration](#ebx-configuration) section.


### Deploy EBX on AKS (Azure Kubernetes Service)

This is an example of EBX deployment on AKS with TLS configured.
It's using TLS with [Let's Encrypt](https://letsencrypt.org/) certificates provide by [cert-manager](https://github.com/cert-manager/cert-manager).

Please see the following Azure documentation to see [how to use TLS with an ingress controller on Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli)

**Note**:
You must add the following annotations in [ingress-annotations-values.yaml](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/ebx-generic/ingress-annotations-values.yaml)

```
nginx.ingress.kubernetes.io/use-regex: "true"
cert-manager.io/cluster-issuer: letsencrypt
```
helm install command: 

```
helm upgrade ebx-chart \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=docker.registry.com:1234/ebx:6.1.0 \
 --set-string global.hostname=ebx.hostname-example.com \
 --set-string ebx.prefix=s1 \
 --set-string ebx.adminPassword='?Y0urP4ssWord!' \
 --set-string ebx.databaseName=ebxDb \
 --set-string ebx.databaseUser=abxDbUser \
 --set-string ebx.databasePwd='+Jjf6frs7?' \
 --set-string ebx.databaseHost=sqlserver.db-host.com \
 --set-string ebx.databasePort=1245 \
 --set-string ebx.databaseType=sqlserver \
 --set-string ingress.tlsSecret=letsencrypt-tls-secret \
 ./ebx-generic-chart
```

### Deploy EBX on EKS (Amazon Elastic Kubernetes Service)

This is an example of EBX deployment on EKS (Elastic Kubernetes Service).
It's using the [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.5/)

Please check see the following AWS documentation to see [how to Install the AWS Load Balancer Controller add-on](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

**Note**:
You must add the following annotations in [ingress-annotations-values.yaml](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/ebx-generic/ingress-annotations-values.yaml)
```
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
```
helm install command:
```
helm upgrade ebx-chart \
 --install \
 -f ingress-annotations-values.yaml \
 --set-string global.namespace=ebx \
 --set-string global.ebxImage=docker.registry.com:1234/ebx:6.1.0 \
 --set-string global.hostname=ebx.hostname-example.com \
 --set-string ebx.prefix=s1 \
 --set-string ebx.adminPassword='?Y0urP4ssWord!' \
 --set-string ebx.databaseName=ebxDb \
 --set-string ebx.databaseUser=abxDbUser \
 --set-string ebx.databasePwd='+Jjf6frs7?' \
 --set-string ebx.databaseHost=sqlserver.db-host.com \
 --set-string ebx.databasePort=1245 \
 --set-string ebx.databaseType=sqlserver \
 --set-string ingress.className=alb \
 --set-string ingress.pathRegex='*' \
 --set-string ingress.pathType=ImplementationSpecific \
 ./ebx-generic-chart
```

## Init container

The ``sysctl`` init container is designed to leave enough space for the OS running the application server by defining the values 
``vm.max_map_count`` and ``ulimit``.

This specificity is 
[documented in the core product documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/references/performance.html#memory) 
(Check the ``Memory allocated to the operating system`` part)
and its [application for Kubernetes is documented here](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/running_the_image.html#_host_configuration).

## Customize and extend the chart
This chart provides a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software on Kubernetes. 
It's suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case, 
in compliance with the Apache License 2.0. However, we recommend that you extend this chart, rather than modify it. 






           


