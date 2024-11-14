# EHRbase Helm Chart

[![Lint and Test](https://github.com/konateq/ehrbase-helm-chart/actions/workflows/lint-and-test.yml/badge.svg)](https://github.com/konateq/ehrbase-helm-chart/actions/workflows/lint-and-test.yml)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=konateq_ehrbase-helm-chart&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=konateq_ehrbase-helm-chart)
![GitHub Release](https://img.shields.io/github/v/release/konateq/ehrbase-helm-chart)
![GitHub License](https://img.shields.io/github/license/konateq/ehrbase-helm-chart)

This repository contains a Helm chart to deploy [EHRbase](https://github.com/ehrbase/ehrbase) on any Kubernetes cluster.

> [!IMPORTANT]    
> This project is an open-source initiative and does not constitute an official product supported by EHRbase team or
> vitasystems GmbH.

## Prerequisites

- Kubernetes 1.26+
- Helm 3.14.0+

## Usage

To deploy EHRbase using the default configuration, run the following command:

```bash
helm install ehrbase oci://ghcr.io/konateq/charts/ehrbase --namespace ehrbase --create-namespace
```

For additional information on how to use and customize this chart, please refer to
this [README.md](./charts/ehrbase/README.md) and the [Wiki](https://github.com/konateq/ehrbase-helm-chart/wiki) pages.

## Contributing

We would love to have you contribute to this project. Please open an issue or a pull request with your ideas.