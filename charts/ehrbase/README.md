# EHRbase

[EHRbase]() serves as the backend for clinical application systems and electronic health records. It is built upon the
openEHR specifications, an open-platform architecture that allows for the development of flexible and interoperable
health systems. OpenEHR-based applications have a shared information architecture, enabling seamless interoperability
between them.

## Prerequisites

- Kubernetes 1.26+
- Helm 3.14.0+

## Dependencies

This chart depends on the following Bitnami Helm charts:

- [PostgreSQL](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) 20.x.x
- [Redis](https://github.com/bitnami/charts/tree/main/bitnami/redis) 15.x.x

## Usage

### Installing

To deploy EHRbase using the default configuration, run the following command:

```bash
helm install <RELEASE_NAME> oci://ghcr.io/konateq/charts/ehrbase --namespace <NAMESPACE> --create-namespace
```

To deploy EHRbase with a custom configuration, create a `values.yaml` file with your desired configuration and run the
following command:

```bash
helm install <RELEASE_NAME> oci://ghcr.io/konateq/charts/ehrbase --namespace <NAMESPACE> --create-namespace -f values.yaml
```

### Uninstalling

To uninstall the EHRbase deployment, run the following command:

```bash
helm uninstall <RELEASE_NAME> --namespace <NAMESPACE>
```

### Upgrading

To upgrade the EHRbase deployment, run the following command:

```bash
helm upgrade <RELEASE_NAME> oci://ghcr.io/konateq/charts/ehrbase --install --namespace <NAMESPACE> -f values.yaml
```

## Configuration

If you look for concrete examples of how to configure this chart in real-world scenarios, please refer to the Wiki page
of this repository.

## Parameters

The following table lists the configurable parameters of the EHRbase chart and their default values.

> [!NOTE]
> For more information on how to customize the PostgreSQL and Redis dependencies, please refer to the respective charts'
> documentation. The PostgreSQL chart documentation can be
> found [here](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) and the Redis chart documentation can be
> found [here](https://github.com/bitnami/charts/tree/main/bitnami/redis).

| Parameter                                    | Description                             | Default                        |
|----------------------------------------------|-----------------------------------------|--------------------------------|
| `auth.enabled`                               | Enable basic authentication             | `true`                         |
| `auth.username`                              | Username                                | `ehrbase-user`                 |
| `auth.password`                              | Password                                | `""`                           |
| `auth.adminUsername`                         | Admin username                          | `ehrbase-admin`                |
| `auth.adminPassword`                         | Admin password                          | `""`                           |
| `auth.existingSecret`                        | Existing secret for user passwords      | `""`                           |
| `configuration`                              | EHRbase configuration                   | `""`                           |
| `tls.enabled`                                | Enable TLS                              | `false`                        |
| `tls.existingSecret`                         | Existing secret for TLS                 | `""`                           |
| `replicaCount`                               | Number of replicas                      | `1`                            |
| `image.repository`                           | EHRbase image repository                | `ehrbase/ehrbase`              |
| `image.pullPolicy`                           | EHRbase image pull policy               | `Always`                       |
| `image.tag`                                  | EHRbase image tag                       | `""`                           |
| `imagePullSecrets`                           | Image pull secrets                      | `[]`                           |
| `nameOverride`                               | Override the chart name                 | `""`                           |
| `fullnameOverride`                           | Override the full name                  | `""`                           |
| `serviceAccount.create`                      | Create service account                  | `true`                         |
| `serviceAccount.automount`                   | Automount service account token         | `true`                         |
| `serviceAccount.annotations`                 | Service account annotations             | `{}`                           |
| `serviceAccount.name`                        | Service account name                    | `""`                           |
| `deploymentAnnotations`                      | Deployment annotations                  | `{}`                           |
| `podAnnotations`                             | Pod annotations                         | `{}`                           |
| `podLabels`                                  | Pod labels                              | `{}`                           |
| `podSecurityContext`                         | Pod security context                    | `{}`                           |
| `securityContext.allowPrivilegeEscalation`   | Allow privilege escalation              | `false`                        |
| `securityContext.capabilities.drop`          | Drop capabilities                       | `["ALL"]`                      |
| `securityContext.readOnlyRootFilesystem`     | Read-only root filesystem               | `true`                         |
| `securityContext.runAsNonRoot`               | Run as non-root                         | `true`                         |
| `securityContext.runAsUser`                  | Run as user                             | `1001`                         |
| `securityContext.seccompProfile.type`        | Seccomp profile type                    | `RuntimeDefault`               |
| `service.type`                               | Service type                            | `ClusterIP`                    |
| `service.port`                               | Service port                            | `8080`                         |
| `service.managementPort`                     | Management port                         | `9000`                         |
| `service.annotations`                        | Service annotations                     | `{}`                           |
| `ingress.enabled`                            | Enable ingress                          | `false`                        |
| `ingress.className`                          | Ingress class name                      | `""`                           |
| `ingress.annotations`                        | Ingress annotations                     | `{}`                           |
| `ingress.hosts[0].host`                      | Ingress host                            | `ehrbase.local`                |
| `ingress.hosts[0].paths[0].path`             | Ingress path                            | `/`                            |
| `ingress.hosts[0].paths[0].pathType`         | Ingress path type                       | `ImplementationSpecific`       |
| `ingress.tls`                                | Ingress TLS                             | `[]`                           |
| `resources`                                  | Pod resources                           | `{}`                           |
| `livenessProbe.httpGet.path`                 | Liveness probe path                     | `/management/health/liveness`  |
| `livenessProbe.httpGet.port`                 | Liveness probe port                     | `management`                   |
| `livenessProbe.initialDelaySeconds`          | Liveness probe initial delay            | `15`                           |
| `readinessProbe.httpGet.path`                | Readiness probe path                    | `/management/health/readiness` |
| `readinessProbe.httpGet.port`                | Readiness probe port                    | `management`                   |
| `readinessProbe.initialDelaySeconds`         | Readiness probe initial delay           | `15`                           |
| `autoscaling.enabled`                        | Enable horizontal pod autoscaling       | `false`                        |
| `autoscaling.minReplicas`                    | Minimum replicas                        | `1`                            |
| `autoscaling.maxReplicas`                    | Maximum replicas                        | `10`                           |
| `autoscaling.targetCPU`                      | Target CPU utilization percentage       | `80`                           |
| `autoscaling.targetMemory`                   | Target memory utilization percentage    |                                |
| `extraEnvVars`                               | Extra environment variables             | `[]`                           |
| `extraEnvVarsSecret`                         | Extra environment variables from secret | `""`                           |
| `extraVolumes`                               | Extra volumes                           | `[]`                           |
| `extraVolumeMounts`                          | Extra volume mounts                     | `[]`                           |
| `nodeSelector`                               | Node selector                           | `{}`                           |
| `tolerations`                                | Tolerations                             | `[]`                           |
| `affinity`                                   | Affinity                                | `{}`                           |
| `postgresql.enabled`                         | Enable PostgreSQL dependency chart      | `true`                         |
| `externalDatabase.host`                      | External database host                  | `""`                           |
| `externalDatabase.port`                      | External database port                  | `5432`                         |
| `externalDatabase.username`                  | External database user                  | `ehrbase`                      |
| `externalDatabase.password`                  | External database password              | `""`                           |
| `externalDatabase.database`                  | External database name                  | `ehrbase`                      |
| `externalDatabase.existingSecret`            | Existing secret for external database   | `""`                           |
| `externalDatabase.existingSecretPasswordKey` | Existing secret password key            | `""`                           |
| `redis.enabled`                              | Enable Redis dependency chart           | `false`                        |
| `externalRedis.enabled`                      | Enable external Redis                   | `false`                        |
| `externalRedis.host`                         | External Redis host                     | `""`                           |
| `externalRedis.port`                         | External Redis port                     | `6379`                         |
| `externalRedis.password`                     | External Redis password                 | `""`                           |
| `externalRedis.existingSecret`               | Existing secret for external Redis      | `""`                           |
| `externalRedis.existingSecretPasswordKey`    | Existing secret password key            | `""`                           |

