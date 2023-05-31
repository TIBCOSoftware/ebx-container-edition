# EBX Container Edition

## Overview

This repository provides a reference and starting point for deploying [TIBCO EBX® Software](https://www.tibco.com/products/tibco-ebx-software) 
on a [Kubernetes cluster](http://kubernetes.io/) using its [container form](https://www.docker.com/resources/what-container) 
(TIBCO EBX® Container Edition) and the [Helm package manager](https://helm.sh/) .

This repository include quick guides, templates, configuration examples, and scripts that you can extend or customize.

This repository does not include TIBCO EBX® software, TIBCO EBX® Container Edition or any other third party software.

**Note**: TIBCO EBX Software is a commercially licensed product and is subject to the payment of license fees.
You must have a valid license to use it.


## Prerequisites

- Required TIBCO EBX® Container Edition image. TODO "how to get it" + Guide doc link
- Kubernetes 1.23+, a working Kubernetes cluster from a [certified K8s distro](https://www.cncf.io/certification/software-conformance/).
- Helm 3+, for building and deploying the charts.
- An [OCI-compliant](https://opencontainers.org/) container image building tool (for example, `docker`, `podman`, or alternative), for building the container images. TODO to moove into postrges internal example for EBX-INIT

**Note**: For more information on TIBCO EBX® Software and its components, see the [TIBCO EBX® Documentation](https://docs.tibco.com/products/tibco-ebx).

## Deploy EBX

To deploy ebx, check the section relative to the 
[generic chart](https://github.com/tibco/ebx-container-edition/blob/main/helm/chart/README.md).

## Example 

The [example section](https://github.com/tibco/ebx-container-edition/blob/main/helm/examples/README.md) contains some configuration or chart examples to deploy ebx.

They refer to particular cases, or to configurations proposed by official distro.

These examples are only propositions, therefore they are not imperative and can be  extend or customize.

## Issues

You are welcome to raise issues and improvements related to this project in the [GitHub Issues tab](https://github.com/tibco/ebx-container-edition/issues).

For issues related to third party products, see their respective documentation.

## License

TODO

---

Copyright 2022-2023 Cloud Software Group, Inc.
... TODO 
