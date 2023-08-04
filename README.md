# Samples Charts for TIBCO EBX Container Edition®

## Overview

This repository provides useful samples for deploying [TIBCO EBX® software](https://www.tibco.com/products/tibco-ebx-software) 
on a [Kubernetes cluster](http://kubernetes.io/) using TIBCO EBX® Container Edition and the [Helm package manager](https://helm.sh/).

This repository includes quick start guides, templates, configuration examples, and scripts that you can extend or customize.

This repository does not include TIBCO EBX software, TIBCO EBX Container Edition, or any other third-party software.

These charts are examples only and we do not guarantee that they will be kept up to date or that they will be suitable 
for your implementation.

The provided samples are "AS IS" and may not be suitable for your needs.

**Note**: TIBCO EBX software and TIBCO EBX Container Edition are commercially licensed products that are subject to 
the payment of license fees. You must have a valid license to use them. 


## Prerequisites

- [TIBCO EBX Container Edition](https://docs.tibco.com/pub/ebx/latest/doc/html/en/index.html?page=ece/building_the_image.html) 
 v6.1.2+.
- [Kubernetes](https://kubernetes.io/) v1.23+, a working Kubernetes cluster from a [certified Kubernetes software](https://www.cncf.io/certification/software-conformance/).
- [Helm](https://helm.sh/) v3+ to build and deploy the charts.

**Note**:
You must generate the image containing all the add-ons you need. 
Refer to [Building the image](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/building_the_image.html#_building_the_image) for more information.
For details about TIBCO EBX® software, see the [TIBCO EBX Documentation](https://docs.tibco.com/products/tibco-ebx).

## Tested certified Kubernetes implementation

The charts contained in this file have been tested on the following certified Kubernetes implementations:

* [Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/)
* [Amazon Elastic Kubernetes Service](https://aws.amazon.com/eks/)
* [MicroK8s](https://microk8s.io/)
* [Red Hat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift)

[Supported versions](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/running_the_image.html#_support_policy)

## Deploying the EBX® image

For information on deploying an EBX image, see the 
[generic chart](/helm/chart/README.md).

## License

This project (Samples Charts for TIBCO EBX Container Edition®) is licensed under the [Apache 2.0 License](LICENSE.txt).

---

Copyright 2023 Cloud Software Group, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the 
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an 
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific 
language governing permissions and limitations under the License.