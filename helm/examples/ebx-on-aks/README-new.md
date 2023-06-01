
# Overview

This file explains the configuration of an AKS cluster on which EBX has been deployed. 

This file also contains an installation example using the ebx-generic-chart. 

## Prerequisites

- Kubernetes 1.23+
- Helm 3+

## Cluster Configuration 


- [Create an ingress controller in AKS](https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli)
- [TLS with an ingress controller](https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli)


## Recommendations

If you use cert-manager fro TLS... do not forget to install a ClusterIssuer 

## Deploy EBX 

