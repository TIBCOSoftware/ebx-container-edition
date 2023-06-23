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

Before installing the chart, you may need to adjust the required values in the [configuration file](https://github.com/tibco/ebx-container-edition/tree/main/helm/chart/ebx-generic/config-values.yaml)  
according to your needs.

**Note**:
The values provided in this file are examples only.
Please see the [Configuration section](#Configuration) for more information.

### Install the chart

Create the ebx namespace:

```
kubectl create namespace ebx
```

Install the chart with the release name `ebx-chart` in the namespace ```ebx```:

```
 helm upgrade ebx-chart  --install -f config-values.yaml ./ebx-generic-chart
```
**Notes**:
This command must be run from the ```helm/chart/ebx-generic``` directory.

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

----------

## Installation examples

Examples of configuration files are included in this directory.
These files provide examples for deploying EBX on different Kubernetes clusters types with different types of databases.

They match the following naming convention:
```
config-values-<a Kubernetes cluster type>-<a database type>.yaml
```

You can deploy them simply by following the installation process explained in section [Install the chart](#Install the chart)
and by replacing the name of the configuration file you want to use as explained here:

```
helm upgrade ebx-chart  --install -f config-values-microk8s-sql.yaml ./ebx-generic-chart
```

Some of these examples have a dedicated section below to clarify some information.

These examples are only propositions, therefore they are not imperative and can be extended or customized.

**Note**: Some jdbc drivers are not included in the original EBX image, please refer to the following
[documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md)
for more information.


### Deploy EBX on AKS (Azure Kubernetes Service)

The [config-values-aks-sql](https://github.com/tibco/ebx-container-edition/tree/main/helm/chart/ebx-generic/config-values-aks-sql.yaml) 
configuration file provide an example of an EBX deployment on AKS with an SQL Database and TLS configured.

It's using TLS with [Let's Encrypt](https://letsencrypt.org/) certificates provide by [cert-manager](https://github.com/cert-manager/cert-manager).
This example assumes that `` cert-manager``  is already installed in your cluster.

Please see the following Azure documentation know [how to use TLS with an ingress controller on Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli)

### Deploy EBX on EKS (Amazon Elastic Kubernetes Service)

The [config-values-eks-sql](https://github.com/tibco/ebx-container-edition/tree/main/helm/chart/ebx-generic/config-values-eks-sql.yaml)
configuration file provide an example of EBX deployment on EKS (Elastic Kubernetes Service).

It's using the [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.5/)
This example assumes that the `` AWS Load Balancer Controller``  is already installed in your cluster.

Please see the following AWS documentation to know [how to Install the AWS Load Balancer Controller add-on](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

#### Reach out the your ebx instance: 

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

## Customize and extend the chart
This chart provides a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software on Kubernetes. 
It's suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case. 






           


