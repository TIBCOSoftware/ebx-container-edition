# EBX generic

## Overview

This document provides an overview of the Helm chart for EBX, its required prerequisites, installation instructions, and configuration information. This chart is generic enough that it should work on most Kubernetes clusters.

Test this chart using the [Nginx Ingress Controller](https://github.com/kubernetes/ingress-nginx)
(maintained by the Kubernetes community). The Nginx Ingress Controller should be installed before deploying this chart. This documentation will indicate when another Ingress controller should be used.

**Attention**: The values provided in this document are examples only. Please see the [Configuration section](#Configuration) for more detailed information about each parameter. Also, note that you must run all commands shown in this file from the `helm/chart/ebx-generic` directory.

## Prerequisites

The following are prerequisites:

- Kubernetes v1.23+ a working Kubernetes cluster from a `certified Kubernetes Software`
  except some particular version such as `Red Hat OpenShift`
- Helm v3+
- EBX (Container Edition) image pushed on your docker registry
- Make any required adjustments to values in the [config-values file](/helm/chart/ebx-generic/config-values.yaml).

**Note**:
The EBX and init image architecture (the CPU type) must match the cluster's. EBX is tested on
the amd64 architecture. Other architectures might work, but are not officially supported.

## Installing the Chart

To install the chart:

1. Open a Shell environment at the `helm/chart/ebx-generic` directory.
2. Create the `ebx` namespace:

```
kubectl create namespace ebx
```

3. In the `ebx` namespace created in the previous step, install the chart with the release name `ebx-chart`:

```
 helm upgrade ebx-chart  --install -f config-values.yaml ./ebx-generic-chart
```

## Uninstalling the Chart

To uninstall the chart, open a terminal or command prompt at the `helm/chart/ebx-generic` directory:

```
helm delete ebx-chart
```

## Configuration

This section describes parameters for the following:

- [Global configuration](#global-configuration)
- [EBX configuration](#ebx-configuration)
- [Ingress configuration](#ingress-configuration)
- [Samples configuration](#samples-configuration)

### Global configuration

| Name                            | Description                                                                                                   | Value      |
|---------------------------------|---------------------------------------------------------------------------------------------------------------|------------|
| `global.ebxImage`               | The EBX Container Edition image. URL                                                                          | `""`       |
| `global.ebxImageRegistrySecret` | The secret that contains the credentials used to connect to the registry that hosts the EBX image (Optional). | `""`       |
| `global.ebxImagePullPolicy`     | The image pull policy for the EBX image.                                                                      | `"Always"` |
| `global.namespace`              | The namespace where EBX will be deployed.                                                                     | `"ebx"`    |
| `global.hostname`               | The hostname used to connect to EBX.                                                                          | `""`       |
| `global.scheme`                 | The scheme that defines the protocol used to connect to EBX (Optional).                                       | `"https"`  |

**Note**:
If the parameter `global.hostname` is not specified, the startupProbe and livenessProbe will not be configured for the 
ebx container.

---

### EBX configuration

| Name                                 | Description                                                                                                                                                                                                                                                                                 | Value                      |
|--------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| `ebx.prefix`                         | The prefix name used for the instance's Kubernetes objects (Pod, Service, Ingress...)                                                                                                                                                                                                       | `""`                       |
| `ebx.adminLogin`                     | The username used to connect to the EBX instance (overrides the `ece` environment variable: `EBX_INSTALL_ADMIN_LOGIN`). This is ignored if the `ebx.flaDisabled` value is not `true`, or if the repository is already initialized.                                                          | `"admin"`                  |
| `ebx.adminPassword`                  | The password used to connect to the EBX instance (overrides the `ece` environment variable: `EBX_INSTALL_ADMIN_PASSWORD`) <b>Attention:</b> This must be enclosed in single quotes. It is ignored if the `ebx.flaDisabled` value is not `true`, or if the repository is already initialized. | `''`                       |
| `ebx.isSecured`                      | If `true`, the HTTPS protocol is assumed. If `false`, the HTTP protocol is assumed (overrides the `ece` environment variable: `EBX_IS_SECURED`)                                                                                                                                             | `'true'`                   |
| `ebx.flaDisabled`                    | For security reasons, you might want to disable the first-launch assistant in all circumstances by setting `ebx.flaDisabled` value to `true` (overrides the `ece` environment variable: `EBX_FLA_DISABLED`) (Mandatory on first execution)                                                  | `'true'`                   |
| `ebx.restAuthenticationBasic`        | If set to `true`, Basic authentication for REST services is enabled. (overrides the `ece` environment variable: `EBX_REST_AUTHENTICATION_BASIC`)                                                                                                                                            | `'true'`                   |
| `ebx.cpu`                            | The CPU number allocated to the EBX container.                                                                                                                                                                                                                                              | `"2"`                      |
| `ebx.memory`                         | The EBX container memory limit.                                                                                                                                                                                                                                                             | `"2Gi"`                    |
| `ebx.storageClass`                   | This is used to claim volumes (it takes the default `storageClass` if no value is specified).                                                                                                                                                                                               | `""`                       |
| `ebx.dataVolumeStorageClaim`         | The amount of disk space of the `PersistentVolume` requested by the EBX instance to store it's data.                                                                                                                                                                                        | `"10Gi"`                   |
| `ebx.logsVolumeStorageClaim`         | The amount of disk space requested by the `PersistentVolumeClaim` for the EBX instance's data.                                                                                                                                                                                              | `"2Gi"`                    |
| `ebx.databaseName`                   | The EBX database server name.                                                                                                                                                                                                                                                               | `""`                       |
| `ebx.databaseUser`                   | The EBX database server user.                                                                                                                                                                                                                                                               | `""`                       |
| `ebx.databasePwd`                    | The EBX database server password.                                                                                                                                                                                                                                                           | `""`                       |
| `ebx.databaseHost`                   | The EBX database server host.                                                                                                                                                                                                                                                               | `""`                       |
| `ebx.databasePort`                   | The EBX database server port.                                                                                                                                                                                                                                                               | `""`                       |
| `ebx.databaseType`                   | The EBX database server type.                                                                                                                                                                                                                                                               | `""`                       |
| `ebx.databaseEncrypt`                | A property for JDBC SQL connection (Optional).                                                                                                                                                                                                                                              | `"true"`                   |
| `ebx.databaseTrustServerCertificate` | A property for JDBC SQL connection (Optional).                                                                                                                                                                                                                                              | `"false"`                  |
| `ebx.databaseHostNameInCertificate`  | A property for JDBC SQL connection (Optional) - The host name to be used to validate the SQL Server TLS/SSL certificate.                                                                                                                                                                    | `"*.database.windows.net"` |
| `ebx.databaseLoginTimeout`           | A property for JDBC SQL connection (Optional) - The number of seconds the driver should wait before timing out a failed connection.                                                                                                                                                         | `"30"`                     |
| `ebx.setSecurityContext`             | Sets the way that Kubernetes checks and manages ownership and permissions for mounted volumes. This option may be required to allow the EBX pod to access mounted volumes.                                                                                                                  | `"false"`                  |
| `ebx.setVmMaxMapCount`               | Change the vm.max_map_count value if needed (must be set to true to be activated)                                                                                                                                                                                                           | `"false"`                  |

**Notes**:
- The parameter `ebx.isSecured` is used by EBX to compute URLs. It should be set to `true` if routes from outside the cluster are
  HTTPS.
- The storage class specified by `ebx.dataStorageClass` must map to high-performance (preferably SSDs) persistent
  volumes. Network disks must be avoided and are not supported.
- The storage class specified by `ebx.logsStorageClass` may be general-purpose disks (but not too slow).
- By default, a volume created by a Persistent Volume Claim (PVC) will be destroyed if the corresponding PVC is deleted
  or modified. No data will be lost, but EBX will need to recreate its indexes at the next boot, which may take some
  time.
- For `ebx.databaseType` refer to
  [this documentation](/docs/databases-connectivity.md)
  to see the compatible databases and their associated values types for the chart.
- For security reasons, when EBX is directly exposed to the Internet, `EBX_FLA_DISABLED` should be set
  to `true` (the default). This requires setting `ebx.adminLogin` and `ebx.adminPassword` if the
  container is starting on an empty database. These parameters are ignored if the database is already initialized.

---

### Ingress configuration

| Name                      | Description                                                                                                                           | Value      |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------|------------|
| `ingress.className`       | The name of the chosen ingress-controller.                                                                                            | `"nginx"`  |
| `ingress.tlsSecret`       | The secret that contains the self-signed certificate and private key (Optional).                                                      | `""`       |
| `ingress.hostRuleDefined` | Modifies the syntax of the ingress resource according to this value. If set to `true`, a host field is added to the ingress resource. | `"true"`   |
| `ingress.annotations`     | The annotations used to configure the ingress resource.                                                                               | `""`       |
| `ingress.pathType`        | The ingress path type.                                                                                                                | `"Prefix"` |

**Note**:
For annotations (`ingress.annotations` field) please see the Annotations section of the Ingress-Nginx Controller
documentation to best meet your needs.

### Samples configuration

| Name                                          | Description                                                                                                                                                                                                                                               | Value     |
|-----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `samples.postgresqlDynamicProvisioningEnable` | If set to `true`, the `ebx-init` container is added and `postgresServer` secret is created. This enable use of the [Deploy EBX with dynamic provisioning of postgresql databases](#deploy-ebx-with-dynamic-provisioning-of-postgresql-databases) example. | `"false"` |
| `samples.isOpenShift`                         | If set to `true`, a route resource will be created instead of an ingress resource.                                                                                                                                                                        | `"false"` |

---

## Security context

Although it is not necessary on all kubernetes clusters, it might be necessary to set securityContext  to allow 
the EBX pod to access mounted volumes.

If the EBX pods fails because it cannot create files on mounted volumes, add the following lines in your configuration file:
```
ebx:
  setSecurityContext: "true"
```

## Init container

While the init container isn't necessary, it can help to adjust `vm.max_map_count` if it's lower than required.

To activate it you can add the following code in your configuration file:
```
ebx:
  setVmMaxMapCount: "true"
```

For more information, please check the EBX documentation [here](https://docs.tibco.com/pub/ebx/latest/doc/html/en/references/performance.html#memory).
Please pay particular attention to the _Memory allocated to the operating system_ section.

---

## Installation examples

Example of configuration files for deploying EBX on different Kubernetes clusters and databases are included in the [configurations directory](/helm/chart/ebx-generic/configurations). These samples are just suggestions. You can modify or expand them as needed.

Some examples have a:

- Dedicated directory to contain annex files.
- dedicated section below to clarify some information.

You can deploy by following the installation process explained in section [Installing the chart](#installing-the-chart). 
Just ensure that the configuration file name is replaced as shown below:

```
helm upgrade ebx-chart --install -f configurations/config-values-you-want.yaml ./ebx-generic-chart
```

**Note**: Some JDBC drivers are not included in the original EBX image. See the [documentation](/docs/databases-connectivity.md)
for more information.

### Deploy EBX on AKS (Azure Kubernetes Service)

The [config-values-aks-sql](/helm/chart/ebx-generic/configurations/config-values-aks-sql.yaml)
configuration file provides an example of an EBX deployment on AKS with an SQL Database and TLS configured.

It uses TLS with `Let's Encrypt` certificates provide by `cert-manager`.
This example assumes that ` cert-manager` is already installed in your cluster.

Please see the Azure AKS documentation for details.

### Deploy EBX on EKS (Amazon Elastic Kubernetes Service)

The [config-values-eks-sql](/helm/chart/ebx-generic/configurations/config-values-eks-sql.yaml)
configuration file provide an example of EBX deployment on EKS (Elastic Kubernetes Service).

It uses the `AWS Load Balancer Controller`.
This example assumes that the ` AWS Load Balancer Controller` is already installed in your cluster.

Please see the AWS EKS documentation for details.

**Note**:
Please see the `Ingress annotations` AWS Load Balancer Controller documentation for details.

#### Reach out the ebx instance:

With this implementation, AWS will create an `EC2 Application LoadBalancer (ALB)`
dynamically when an EBX ingress resource is created.
This ALB has a DNS which will be the entry point to reach your EBX instance.

To get the DNS entry point, you can run the following command and check the `ADDRESS` value of your ingress resource:

```
kubectl get ingress -n ebx
```

The URL will then be in the following form:

```
<aws load balancer dns >/<.Values.ebx.prefix>/
```

### Deploy EBX on RedHat OpenShift

The [config-values-open-shift-sql](/helm/chart/ebx-generic/configurations/config-values-open-shift-sql.yaml)
configuration file provide an example of EBX deployment on Red Hat OpenShift Developer Sandbox.

You do not need to install an ingress controller for this example because the OpenShift clusters uses a custom solution 
(called ```route```) for routing applications.


Your configuration file must have the values below filled in:
```
ebx:
  setSecurityContext: "false"
  setVmMaxMapCount: "false"

samples:
  isOpenShift: "true"
```

On OpenShift setting, `setVmMaxMapCount` to `true` is usually not necessary. You may check this by running command:
```
kubectl -n <ebx-pod-namespace> exec -it <ebx-pod-name> -- sysctl -n vm.max_map_count
```
The returned value should be greater or equal to 262144

#### isOpenShift
By activating the var isOpenShift you will allow the chart to deploy a resource route instead of an Ingress.

Please see the RedHat OpenShift documentation for details about ```route``` object.

### Deploy EBX with dynamic provisioning of postgresql databases

The [config-values-postgresql-dynamic-provisioning](/helm/chart/ebx-generic/configurations/postgresql-dynamic-provisioning/config-values-postgresql-dynamic-provisioning.yaml)
configuration file provides an example of configuration for deploying EBX on a kubernetes cluster and creates its
PostgreSQL database dynamically.

Each time an EBX instance is created, the init container ([EBX-INIT](#EBX-INIT)) creates a database dedicated to
this instance on the PostgreSQL server.

This example assumes that you have a Postgresql server (11 to 14.x) already configured and the EBX-INIT pushed on your
docker registry.

**Note**:
You need Docker v20.x+ to build the EBX-INIT container image.

#### Mandatory values

If you decide to create your own configuration file following this example, be aware that the following values are mandatory:

```
global:
  # ebxInitImage is the ebx-init image URL
  ebxInitImage: "<your.registry.com/ebx-init:1.0>"

samples:
  # postgresqlDynamicProvisioningEnable if set to `true`, the `ebx-init` container is added and `postgresServer` secret created.
  postgresqlDynamicProvisioningEnable: "true"

# postgresServer section defines specific values for the `postgresServer` connectivity
postgresServer:
  # database is the postgres server master database name
  database: ""
  # user is the postgres server master database user
  user: ""
  # pwd is the postgres server master database password
  pwd: ""
```

To install the chart, use the following command:

```
helm upgrade ebx-chart  --install -f configurations/postgresql-dynamic-provisioning/config-values-postgresql-dynamic-provisionning.yaml ./ebx-generic-chart
```

#### EBX-INIT

The `ebx-init` init container is made to initialize a postgresql database for an EBX instance.

It's based on an `alpine:3.14.3` image and contains:

- the postgresql-client
- bash
- the set-up-database.sh script

A [bundle](/helm/chart/ebx-generic/configurations/postgresql-dynamic-provisioning/ebx-init)
is provided to help you to build and push the ebx-init image.

**Note**: The script
[set-up-database.sh](/helm/chart/ebx-generic/configurations/postgresql-dynamic-provisioning/ebx-init/scripts/set-up-database.sh)
need to be updated to be compatible with postgresql 15.

## Customize and extend the chart

This chart provides a standard, canonical, typical, or vanilla deployment for the TIBCO EBX® Software on Kubernetes.
It's suitable for most of the use case scenarios.

You are welcome to use and modify the chart and adapt it to your specific use case.
