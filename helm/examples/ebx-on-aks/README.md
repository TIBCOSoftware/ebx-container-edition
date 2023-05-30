

# ECE on AKS

This chart provides an example to deploy EBX Container Edition (ECE) on an Azure Kubernetes
Service (AKS).

This chart is based on the ebx-postgresql-internal example (TODO link) chart that bootstraps an EBX 
deployment configured with an internal Postgresql using the Helm package manager.

This chart shows an example of configuration using an ingress controller and TLS certificates installed on the cluster.

This file assumes you have already configured your cluster according to the following requirements :
- Create an ingress controller in AKS (TODO Link : https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli)
- TLS with an ingress controller (TODO link : https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli)
- PostgreSQL v10 to 14 (maintained by Bitnami)

Note: Using the PostgreSQL database like this is not recommended for production use. Make sure you know how to back up and restore your data when using this chart for other than testing purposes.

## Prerequisites

- Kubernetes 1.23+
- Helm 3+
- Both EBX (Container Edition) and EBX-INIT images pushed on your docker registry

## What change?
cette partie montre les modifications apportée au chart ...

Le ClusterIssuer

L'email (instance.emailClusterIssuer) 

## Installing the Chart

```
helm upgrade --debug production --namespace ingress-ece \
 --install \
 --set-string global.namespace=ingress-ece \
 --set-string global.ebxImageRegistry=eceregistry.azurecr.io \
 --set-string global.ebxImageTag=6.0.4-RC.1166-hf-0001-mame-tese-dint-dama-dpra-dmdv-5.2.0 \
 --set-string global.ebxInitImageRegistry=eceregistry.azurecr.io \
 --set-string global.ebxInitImageTag=latest \
 --set-string global.hostname=ece-on-aks.westeurope.cloudapp.azure.com \
 --set-string instance.ebxPrefix=production \
 --set-string instance.emailClusterIssuer=cjannes@tibco.com \
 --set-string instance.ebxPassword=abcde1458 \
 --set-string ingress.tlsSecret=letsencrypt-tls-secret \
 --set-string database.name=dbebx \
 --set-string database.user=ebxdbuser \
 --set-string database.pwd=abcde1458 \
 --set-string database.host=postgres-ebx-postgresql \
 --set-string database.port=5432 \
 --set-string database.type=postgresql \
 --set-string postgresServer.name=masterdb \
 --set-string postgresServer.user=postgres \
 --set-string postgresServer.pwd=ftefg32 \
 ./ebx-chart
```
