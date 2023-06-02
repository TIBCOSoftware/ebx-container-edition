# EBX Container Edition

## Overview

This repository provides a useful samples for deploying [TIBCO EBX® Software](https://www.tibco.com/products/tibco-ebx-software) 
on a [Kubernetes cluster](http://kubernetes.io/) using its [container form](https://www.docker.com/resources/what-container) 
(TIBCO EBX® Container Edition) and the [Helm package manager](https://helm.sh/) .

This repository include quick guides, templates, configuration examples, and scripts that you can extend or customize.

This repository does not include TIBCO EBX® software, TIBCO EBX® Container Edition or any other third party software.

**Note**: TIBCO EBX Software is a commercially licensed product and is subject to the payment of license fees.
You must have a valid license to use it.

## Prerequisites

- TIBCO EBX® Container Edition 6.0.15+ (Reference TODO)
- [Kubernetes](https://kubernetes.io/) 1.23+, a working Kubernetes cluster from a [certified K8s distro](https://www.cncf.io/certification/software-conformance/).
- [Helm](https://helm.sh/) 3+, for building and deploying the charts.

**Note** 

You need to generate the image containing all the addons you need. 
For generating ... (Building the image)
For details please see ref... todo 

For more information on TIBCO EBX® Software and its components, see the [TIBCO EBX® Documentation](https://docs.tibco.com/products/tibco-ebx).

## Tested cluster

The charts contained in this file have been tested on the following kubernetes cluster:

* [Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/) (AKS) TODO version
* [Amazon Elastic Kubernetes Service](https://aws.amazon.com/fr/eks/) (EKS) TODO TODO version
* [MicroK8s](https://microk8s.io/) TODO version

## Deploying EBX image

To deploy an ebx image, check the section relative to the 
[generic chart](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/README.md).

## Examples 

The [example section](https://github.com/tibco/ebx-container-edition/blob/main/helm/examples/README.md) contains some 
configuration or chart examples to deploy ebx.

They refer to particular cases, or to configurations proposed for specific Kubernetes implementation.

These examples are only propositions, therefore they are not imperative and can be extended or customized.

## Issues (A faire valider par cln)

You are welcome to raise issues and improvements related to this project in the [GitHub Issues tab](https://github.com/tibco/ebx-container-edition/issues).

For issues related to third party products, see their respective documentation.

## License

TODO

---

Copyright 2022-2023 Cloud Software Group, Inc.
... TODO 
