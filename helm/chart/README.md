# EBX generic

## Overview

This sample is a Helm chart for EBX.

This chart is a generic example, that should work on most Kubernetes cluster. 

This chart was tested on most clusters with the [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) 
maintained by the Kubernetes community. 
This chart assumes it is already installed on your cluster.

**Note**:
For specific examples, this chart may have been tested with other Ingress controllers, in which case it will be 
indicated in this documentation.

TODO pch review above

## Prerequisites

* Kubernetes v1.23+, a working Kubernetes cluster from a [certified Kubernetes Software](https://www.cncf.io/certification/software-conformance/) 
except some particular version such as [Red Hat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift).
* Helm v3+
* EBX (Container Edition) image pushed on your docker registry

**Note**:
The architecture / type of CPU of the images (EBX and init containers) must match that of the cluster.

TODO pch review NOTE

## Installing the Chart

Before installing the chart, you may need to adjust the required values in the [configuration file](/helm/chart/ebx-generic/config-values.yaml)  
according to your needs.

All commands provide in this file must be run from the ```helm/chart/ebx-generic``` directory.

**Note**:
The values provided in this file are examples only. Please see the [Configuration section](#Configuration) for more 
information.


### Install the chart

Create the ebx namespace:

```
kubectl create namespace ebx
```

Install the chart with the release name `ebx-chart` in the namespace ```ebx```:

```
 helm upgrade ebx-chart  --install -f config-values.yaml ./ebx-generic-chart
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
- TODO pch review : ebx.isSecured defines the protocol assumed by EBX for its internal operation. 
This means that the protocol used at the entry point must fit with the value of this variable. 
ex : if ebx.isSecured=true https must be defined. We therefore recommend that you use the https protocol for security 
reasons.
- TODO pch review : Selected data disks defined by ```ebx.dataStorageClass``` must be high-performance (preferably SSDs) 
and network disks should be avoided. For logs disk defined by ```ebx.logsStorageClass``` general-purpose disks 
(but not too slow) can be used.
You should also be aware that the volume will be destroyed if the corresponding PVC is deleted or modified. This means that EBX will 
have to recreate its indexes at the next boot, which may take some time. However, there will be no loss of data.
Please see the [storageClass documentation](https://kubernetes.io/docs/concepts/storage/storage-classes/)
and the [dynamic volume provisioning concept](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for
further information.
- For ```ebx.databaseType``` refer to
[this documentation](https://github.com/tibco/ebx-container-edition/blob/1d0bba574ee6b38f3ac57194ecdc89214c63611d/docs/databases-connectivity.md)
to see the compatible databases and their associated values types for the chart.
- TODO pch review : The ```EBX_FLA_DISABLED``` is by default set to ```true```. The reason for this is that if the repo has not yet been 
initialized, you must set its value to true in order to initialize variables ```ebx.adminLogin``` and 
```ebx.adminPassword```. If the repo is already initialised, these  values 
defined via the Helm command will be ignored and will retain the values set when the repo was initialised.
- Every jdbc sql connection property will only be used if ```ebx.databaseType``` value equals to ```sqlserver``` or ```azure.sql```.
  check the [official documentation](https://learn.microsoft.com/en-us/sql/connect/jdbc/setting-the-connection-properties?view=sql-server-ver16)
  for information about to setting the sql connection properties.

----------

### Ingress configuration

| Name                      | Description                                                                                                                                        | Value      |
|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|------------|
| `ingress.className`       | className is the name of the chosen ingress-controller                                                                                             | `"nginx"`  |
| `ingress.tlsSecret`       | tlsSecret that contains the self-signed certificate and private key (Optional)                                                                     | `""`       | 
| `ingress.hostRuleDefined` | hostRuleDefined modify the syntax of the ingress resource according to this value. If set to true, an host field is added to the ingress resource. | `"true"`   |
| `ingress.annotations`     | annotations to configure the ingress resource                                                                                                      | `""`       |
| `ingress.pathType`        | pathType is pathType of the ingress                                                                                                                | `"Prefix"` |

**Note**:
For annotations (```ingress.annotations``` field) please refer to the 
[following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) 
to best meet your needs.

### Examples configuration

| Name                                            | Description                                                                                                                                                                                                                         | Value     |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `samples.postgresqlDynamicProvisioningEnable`   | If set to true, will add the ebx-init container and create postgresServer secret (to use the [Deploy EBX with dynamic provisioning of postgresql databases](#Deploy EBX with dynamic provisioning of postgresql databases) example) | `"false"` |

----------

## Init container

The ``init`` container is designed to leave enough space for the OS running the application server by defining 
the values ``vm.max_map_count``.

This specificity is 
[documented in the core product documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/references/performance.html#memory) 
(Check the ``Memory allocated to the operating system`` part)
and its [application for Kubernetes is documented here](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/running_the_image.html#_host_configuration).

**Note**:
max open files set by ``ulimit -n`` must have a fairly high value on the host machine.

TODO pch review above

----------

## Installation examples

Examples of configuration files are included in the [configurations directory](https://github.com/tibco/ebx-container-edition/tree/7f9fc8b315679e452debba64533106f175249835/helm/chart/ebx-generic/configurations).
These files provide examples for deploying EBX on different Kubernetes clusters types with different types of databases.

Some examples may have a dedicated directory to contain annex files.

You can deploy them simply by following the installation process explained in section [Install the chart](#Install the chart)
and by replacing the name of the configuration file you want to use as explained here:

```
helm upgrade ebx-chart --install -f configurations/config-values-you-want.yaml ./ebx-generic-chart
```

Some of these examples have a dedicated section below to clarify some information.

These examples are only propositions, therefore they are not imperative and can be extended or customized.

**Note**: Some jdbc drivers are not included in the original EBX image, please refer to the following
[documentation](https://github.com/tibco/ebx-container-edition/blob/7f9fc8b315679e452debba64533106f175249835/docs/databases-connectivity.md)
for more information.


### Deploy EBX on AKS (Azure Kubernetes Service)

The [config-values-aks-sql](https://github.com/tibco/ebx-container-edition/blob/7f9fc8b315679e452debba64533106f175249835/helm/chart/ebx-generic/configurations/config-values-aks-sql.yaml)
configuration file provide an example of an EBX deployment on AKS with an SQL Database and TLS configured.

It's using TLS with [Let's Encrypt](https://letsencrypt.org/) certificates provide by [cert-manager](https://github.com/cert-manager/cert-manager).
This example assumes that `` cert-manager``  is already installed in your cluster.

Please see the following Azure documentation know [how to use TLS with an ingress controller on Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli)

### Deploy EBX on EKS (Amazon Elastic Kubernetes Service)

The [config-values-eks-sql](https://github.com/tibco/ebx-container-edition/blob/7f9fc8b315679e452debba64533106f175249835/helm/chart/ebx-generic/configurations/config-values-eks-sql.yaml)
configuration file provide an example of EBX deployment on EKS (Elastic Kubernetes Service).

It's using the [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.5/)
This example assumes that the `` AWS Load Balancer Controller``  is already installed in your cluster.

Please see the following AWS documentation to know [how to Install the AWS Load Balancer Controller add-on](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

**Note**:
Please see the [ingress annotation documentation](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.5/guide/ingress/annotations/) 
for the AWS Load Balancer Controller to best meet your needs.

#### Reach out the ebx instance:

With this implementation, AWS will create an [EC2 Application LoadBalancer (ALB)](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
dynamically when EBX ingress resource is created.
This ALB has a DNS which will be the entry point to reach your EBX instance.

If you do not attach your personal dns to this load balancer you can use his to reach your EBX instance.

To know the DNS entry point you can run the following command and check the ```ADDRESS``` value of your ingress resource:
```
kubectl get ingress -n ebx
```
The url will then be of the following form :
```
<aws load balancer dns >/<.Values.ebx.prefix>/
```

TODO pch review above

### Deploy EBX with dynamic provisioning of postgresql databases

TODO pch review this section

The [config-values-postgresql-dynamic-provisioning](https://github.com/tibco/ebx-container-edition/blob/7f9fc8b315679e452debba64533106f175249835/helm/chart/ebx-generic/configurations/postgresql-dynamic-provisioning/config-values-postgresql-dynamic-provisioning.yaml) configuration file provide an example of configuration for 
deploying ebx on a kubernetes cluster and create it's PostgreSQL database dynamically.

Each time an EBX instance is created, the init container ([EBX-INIT](#EBX-INIT)) will create a database dedicated to
this instance on the PostgreSQL server.

This example assumes that you have a Postgresql server (11 to 14.x) already configured and the EBX-INIT pushed on your 
docker registry.

**Note**:
You need [Docker](https://www.docker.com/) v20.x+ for building the EBX-INIT container image.

#### Mandatory values

If you decide to create your own configuration file following this example, be aware that these values are mandatory:
```
global:
  # ebxInitImage is the ebx-init image URL 
  ebxInitImage: "<your.registry.com/ebx-init:1.0>"

examples:
  # postgresqlDynamicProvisioningEnable if set to true, will add the ebx-init container and create postgresServer secret.
  postgresqlDynamicProvisioningEnable: "true"

# postgresServer section defines specifics values for the postgresServer connectivity (Optional)
# this section Deploy EBX with dynamic provisioning of postgresql databases
postgresServer:
  # database is the postgres server master database name
  database: ""
  # user is the postgres server master database user
  user: ""
  # pwd is the postgres server master database password
  pwd: ""
```

install command:
```
helm upgrade ebx-chart  --install -f configurations/postgresql-dynamic-provisioning/config-values-postgresql-dynamic-provisionning.yaml ./ebx-generic-chart
```

#### EBX-INIT

The ``ebx-init`` init container is made to initialize a postgresql database for an EBX instance.

It's based on an ```alpine:3.14.3``` image and contains:
- the postgresql-client
- bash
- the set-up-database.sh script

A [bundle](https://github.com/tibco/ebx-container-edition/tree/7f9fc8b315679e452debba64533106f175249835/helm/chart/ebx-generic/configurations/postgresql-dynamic-provisioning/ebx-init)
is provided to help you to build and push the ebx-init image.

**Note**: The script
[set-up-database.sh](https://github.com/tibco/ebx-container-edition/blob/7f9fc8b315679e452debba64533106f175249835/helm/chart/ebx-generic/configurations/postgresql-dynamic-provisioning/ebx-init/scripts/set-up-database.sh) 
need to be updated to be compatible with postgresql 15.

## Customize and extend the chart
This chart provides a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software on Kubernetes. 
It's suitable for most of the use case scenarios.

You are welcome to use and modify the chart and adapt it to your specific use case. 






           


