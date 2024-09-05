# EHRbase Helm Chart

[![Release Charts](https://github.com/konateq/ehrbase-helm-chart/actions/workflows/release.yml/badge.svg)](https://github.com/konateq/ehrbase-helm-chart/actions/workflows/release.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This repository contains a Helm chart to deploy [EHRbase](https://github.com/ehrbase/ehrbase) on a Kubernetes cluster.

> [!IMPORTANT]    
> This project is an open-source initiative and does not constitute an official product endorsed by EHRbase or
> vitasystems GmbH.
> The provided code is distributed on an "AS IS" basis, without warranties of any kind, either express or implied.

## Prerequisites

- Kubernetes 1.26+
- Helm 3.14.0+

## Usage

To deploy EHRbase using the default configuration, run the following command:

```bash
helm install ehrbase oci://ghcr.io/konateq/charts/ehrbase --namespace ehrbase --create-namespace
```

## Contributing

We would love to have you contribute to this project. Please open an issue or a pull request with your ideas.