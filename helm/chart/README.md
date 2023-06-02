# EBX generic chart

## Overview

This sample is a Helm chart for EBX.

This chart is a generic example, that should work on most kubernetes cluster. 

This chart was tested with the [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx) 
maintained by the Kubernetes community. 
This chart assumes it is already installed on your cluster.

## Prerequisites

* Kubernetes 1.23+, a working kubernetes cluster from a [certified K8s distro](https://www.cncf.io/certification/software-conformance/) 
except some particular version such as Redat OpenShift TODO chek name
* Helm 3+
* EBX (Container Edition) image pushed on your docker registry

## Installing the Chart

=TODO 

Before installing the chart you may need to adjust your Ingress annotations according to the architecture of your 
cluster.
To do so, you first need to create your config annotation file as explain here:

--values /<path_to_your_values_file>/<values_file_name>

example :

--values /ingress-config/annotations.yaml

--values /ingress-config-annotations-template/ingress-annotations.yaml

surcharge fichier yaml pour ingress annotations

You first need to create your config file depending on your needs.

Before installing the chart you may need to adjust begin be careful to these points: 
- set the ingress annotations according to the architecture of your cluster 
  (see annotations parameter in the [Ingress parameters](#Ingress-parameters) section).

=TODO

To install the chart with the release name ```production``` in the namespace ```ebx``` (default value):

```
helm upgrade production \
 --install \
 -f ingress-annotations.yaml \
 --set-string global.namespace=ingress-ece \
 --set-string global.ebxImage=eceregistry.azurecr.io/ebx:6.0.4-RC.1166-hf-0001-mame-tese-dint-dama-dpra-dmdv-5.2.0 \
 --set-string global.hostname=ece-on-aks.westeurope.cloudapp.azure.com \
 --set-string ebx.prefix=production \
 --set-string ebx.adminPassword=abcde1458 \
 --set-string ebx.databaseName=db-test-2 \
 --set-string ebx.databaseUser=admin-cja \
 --set-string ebx.databasePwd='!Wh04reU?' \
 --set-string ebx.databaseHost=aks-server-test.database.windows.net \
 --set-string ebx.databasePort=1433 \
 --set-string ebx.databaseType=azure.sql \
 --set-string ingress.tlsSecret=letsencrypt-tls-secret \
 ./ebx-generic-chart
```

TODO review cmd

## Uninstalling the Chart
To uninstall the chart with the release name ```production```:
```
helm delete production
```
----------

## Configuration

### Global configuration

| Name                         | Description                                                                                                 | Value        |
|------------------------------|-------------------------------------------------------------------------------------------------------------|--------------|
| `global.ebxImage`            | The ebx container edition image URL                                                                         | `""`         |
| `global.imageRegistrySecret` | The secret that contains the credentials used to connect to the registry that host the ebx image (Optional) | `""`         |
| `global.namespace`           | The namespace where EBX will be deployed                                                                    | `"ebx"`      |
| `global.hostname`            | The hostname of the kubernetes server host                                                                  | `""`         |
| `global.scheme`              | The scheme that define the protocol of the kubernetes server                                                | `"https"`    |

----------

### EBX configuration

| Name                         | Description                                                                                                                                                                 | Value     |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `ebx.prefix`                 | The prefix name used for every kubernetes object of the instance (Pod, Service, Ingress...)                                                                                 | `""`      |
| `ebx.adminLogin`             | The username used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_LOGIN`)                                                           | `"admin"` |
| `ebx.adminPassword`          | The password used to connect to the ebx instance (overrides ece environment variable : `EBX_INSTALL_ADMIN_PASSWORD`) <b><u>must be enclosed in single quotes<u><b>          | `''`      |
| `ebx.cpu`                    | The cpu number allocate to the ebx container                                                                                                                                | `"2"`     |
| `ebx.memory`                 | The ebx container memory limit                                                                                                                                              | `"2Gi"`   |
| `ebx.storageClass`           | storageClass used to claim volumes                                                                                                                                          | `""`      |
| `ebx.dataVolumeStorageClaim` | The amount of disk space of the PersistentVolume requested by the ebx instance to store it's data (this value must be greater than or equal to the dataVolumeStorage value) | `"10Gi"`  |
| `ebx.logsVolumeStorageClaim` | The amount of disk space requested by the PersistentVolumeClaim for the data of the ebx instance                                                                            | `"2Gi"`   |
| `ebx.databaseName`           | The ebx database server name                                                                                                                                                | `"2Gi"`   |
| `ebx.databaseUser`           | The ebx database server user                                                                                                                                                | `"2Gi"`   |
| `ebx.databasePwd`            | The ebx database server password                                                                                                                                            | `"2Gi"`   |
| `ebx.databaseHost`           | The ebx database server host                                                                                                                                                | `"2Gi"`   |
| `ebx.databasePort`           | The ebx database server port                                                                                                                                                | `"2Gi"`   |
| `ebx.databaseType`           | The ebx database server type                                                                                                                                                | `"2Gi"`   |
| `ebx.databaseEncrypt`        | A property for jdbc sql connection (Optional)                                                                                                                               | `"2Gi"`   |

**Note**: If ```ebx.storageClass``` is not specified, the default storage class will be used for provisioning.
Check the [storageClass documentation](https://kubernetes.io/blog/2017/03/dynamic-provisioning-and-storage-classes-kubernetes/) for further informations.

**Note**: for ```ebx.databaseType``` refer to
[this documentation](https://github.com/tibco/ebx-container-edition/blob/main/docs/databases-connectivity.md)
to see the compatible databases and their associated values types for the chart.

----------

### Ingress configuration

| Name                      | Description                                                                                                       | Value     |
|---------------------------|-------------------------------------------------------------------------------------------------------------------|-----------|
| `ingress.className`       | className is the name of the chosen ingress-controller                                                            | `"nginx"` |
| `ingress.tlsSecret`       | tlsSecret that contains the self-signed certificate and private key                                               | `""`      | 
| `ingress.hostRuleDefined` | hostRuleDefined modify the syntax of the ingress according to this value. If set to true, an host must be defined | `"true"`  |
| `ingress.annotations`     | annotations to configure the ingress resource                                                                     | `""`      |

**Note**: Annotations are provided as comments in the ```ingress.annotations``` section of the [values.yaml file](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/ebx-generic/ebx-generic-chart/values.yaml).
you'll have to uncomment them if you want to activate them.
These are only examples of structure-based configurations, which means your structure may need other 
annotations. TODO modifier en conséquence (surcharge values file)

Please refer to the 
[following documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) 
to best meet your needs.

----------

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

```

### Deploy EBX with a Postgresql database.

```

```

TODO : NOTE -> rappel sur les mots de passe sensible à la casse chez postgresql puis renvoie vers la doc

### Deploy EBX with an sql database.

```

```

**Note**:
encryption is enable by default, you can disable it by adding this line to the above helm command:
--set-string database.encrypt=false \

check the database section in the values.yaml file of the ebx-generic-chart. TODO link

### Deploy EBX with an oracle database.

```

```

### Deploy EBX with an Azure SQL database. TODO

```

```


### Deploy EBX with an SAP HANA database. TODO

```

```


## Init container

The init container is designed to leave enough space for the OS running the application server by defining the values 
``vm.max_map_count`` and ``ulimit -n 512000``.

This specificity is 
[documented in the core product documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/references/performance.html#memory) 
(Check the ``Memory allocated to the operating system`` part)
and its [application for kubernetes is documented here](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/running_the_image.html#_host_configuration).

**Note**: If more than one EBX container may run on the same host at the same time, one needs to increase
these values accordingly.

## Customize and extend the chart
This chart provide a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software on kubernetes. 
It's suitable for most of the use case scenarios.

You are welcome to use and modify the recipes and adapt them to your specific use case, 
in compliance with the Apache License 2.0. However, we recommend that you extend this chart, rather than modify it. 







           


