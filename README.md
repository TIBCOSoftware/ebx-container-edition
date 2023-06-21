# EBX Container Edition

## Overview

This repository provides useful samples for deploying [TIBCO EBX® Software](https://www.tibco.com/products/tibco-ebx-software) 
on a [Kubernetes cluster](http://kubernetes.io/) using TIBCO EBX® Container Edition and the [Helm package manager](https://helm.sh/) .

This repository includes quick guides, templates, configuration examples, and scripts that you can extend or customize.

This repository does not include TIBCO EBX® software, TIBCO EBX® Container Edition or any other third party software.

**Note**: TIBCO EBX Software and TIBCO EBX® Container Edition are commercially licensed products and are subject to 
the payment of license fees.
You must have a valid license to use them.

## Prerequisites

- [TIBCO EBX® Container Edition](https://docs.tibco.com/pub/ebx/6.1.0/doc/pdf/TIB_ebx_6.1.0_container_edition.pdf?id=0) 6.0.15+
- [Kubernetes](https://kubernetes.io/) v1.23+, a working Kubernetes cluster from a [certified K8s software](https://www.cncf.io/certification/software-conformance/).
- [Helm](https://helm.sh/) v3+, for building and deploying the charts.

**Note**:
You need to generate the image containing all the addons you need. 
For generating the image please refer to the [Building the image](https://docs.tibco.com/pub/ebx/6.1.0/doc/html/fr/ece/building_the_image.html#_building_the_image) 
documentation.
For details about TIBCO EBX® Software please see the [TIBCO EBX Documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/fr/index.html).

For more information on TIBCO EBX® Software and its components, see the [TIBCO EBX® Documentation](https://docs.tibco.com/products/tibco-ebx).

## Tested cluster

The charts contained in this file have been tested on the following Kubernetes cluster:

* [Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/) (AKS) v1.25+ 
* [Amazon Elastic Kubernetes Service](https://aws.amazon.com/fr/eks/) (EKS) v1.27+ 
* [MicroK8s](https://microk8s.io/) v1.23+

## Deploying EBX image

For information on deploying an ebx image, see the section relative to the 
[generic chart](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/README.md).

## Examples 

The [example section](https://github.com/tibco/ebx-container-edition/tree/main/helm/examples) contains some 
configuration or chart examples for deploying ebx on a Kubernetes cluster.

They refer to particular cases, or to configurations for specific Kubernetes implementation.

These examples are only propositions, therefore they are not imperative and can be extended or customized.

## License

TODO

---

Copyright 2022-2023 Cloud Software Group, Inc.
... TODO 
