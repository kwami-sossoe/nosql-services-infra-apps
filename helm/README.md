# anthos-infra-apps

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

Helm Chart to deploy Infrastructure.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Bilel ISMAIL | <bilel.ismail-extern@renault.com> |  |
| Julien Vaudour | <julien.vaudour@renault.com> |  |
| Kwami SOSSOE | <kwami.sossoe-extern@renault.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apps.argocd.AdditionalRbacPolicies | object | `{}` | the additional rbac policies of argocd application |
| apps.argocd.admin | object | `{"enabled":true}` | enable admin login |
| apps.argocd.annotations | object | `{}` | annotations of argocd ingress |
| apps.argocd.argocdImageRepo | string | `""` | argocd docker image repo |
| apps.argocd.argocdImageTag | string | `""` | argocd docker image tag |
| apps.argocd.controller.podAnnotations | object | `{"metrics.dynatrace.com/path":"/metrics","metrics.dynatrace.com/port":"8082","metrics.dynatrace.com/scrape":"true","metrics.dynatrace.com/secure":"false"}` | Annotations to be added for pod. added for dynatrace scraping. |
| apps.argocd.controller.resources | object | `{"limits":{"cpu":4,"memory":"4Gi"},"requests":{"cpu":"1000m","memory":"512Mi"}}` | resources for the controller pod |
| apps.argocd.credentialTemplates | object | `{}` | The credentials of repositories to configure for argocd application |
| apps.argocd.enabled | bool | `true` | enables argocd app |
| apps.argocd.extraObjects | list | `[]` | extra k8s objects to create |
| apps.argocd.hosts | string | `""` | hosts Url of argocd application |
| apps.argocd.issuerUrl | string | `""` | issuer Url of argocd application |
| apps.argocd.oidcConfigClientID | string | `""` | oidc Config Client of argocd application |
| apps.argocd.oidcConfigClientSecret | string | `nil` | oidc Config Client Secret of argocd application |
| apps.argocd.oidcConfigName | string | `""` | oidc Config Name of argocd application |
| apps.argocd.redisImageRepo | string | `""` | redis docker image repo |
| apps.argocd.redisImageTag | string | `""` | redis docker image tag |
| apps.argocd.repoServer.podAnnotations | object | `{"metrics.dynatrace.com/path":"/metrics","metrics.dynatrace.com/port":"8084","metrics.dynatrace.com/scrape":"true","metrics.dynatrace.com/secure":"false"}` | Annotations to be added for pod. added for dynatrace scraping. |
| apps.argocd.repoServer.resources | object | `{"limits":{"cpu":2,"memory":"2Gi"},"requests":{"cpu":1,"memory":"512Mi"}}` | resources for the repoServer pod |
| apps.argocd.repositories | object | `{}` | The repositories to configure for argocd application |
| apps.argocd.server.podAnnotations | object | `{"metrics.dynatrace.com/path":"/metrics","metrics.dynatrace.com/port":"8083","metrics.dynatrace.com/scrape":"true","metrics.dynatrace.com/secure":"false"}` | Annotations to be added for pod. added for dynatrace scraping. |
| apps.argocd.server.resources | object | `{"limits":{"cpu":2,"memory":"2Gi"},"requests":{"cpu":1,"memory":"512Mi"}}` | resources for the server pod |
| apps.argocd.syncPolicy | object | `{"disableAuto":null,"disablePrune":null,"disableSelfHeal":null}` | Disables the sync policy for the Argocd application See below |
| apps.argocd.syncPolicy.disableAuto | bool | `nil` | Disable Auto Sync for Argocd App |
| apps.argocd.syncPolicy.disablePrune | bool | `nil` | Disable Auto Prune for Argocd App |
| apps.argocd.syncPolicy.disableSelfHeal | bool | `nil` | Disable Self Heal for Argocd App |
| apps.argocd.targetRevision | string | `"0.6.0"` | Revision of the argocd helm chart |
| apps.argocd.tlsSecretName | string | `""` | Secret name for the tls of argocd application |
| argocd.syncPolicy | object | `{"auto":true,"prune":true,"selfHeal":true}` | Argocd Sync Policy. Can be deactivate per apps |
| argocd.syncPolicy.auto | bool | `true` | Enable [Argocd Auto Sync](https://argoproj.github.io/argo-cd/user-guide/auto_sync/#automated-sync-policy) |
| argocd.syncPolicy.prune | bool | `true` | Enable [ArgoCd Autoprune](https://argoproj.github.io/argo-cd/user-guide/auto_sync/#automatic-pruning) |
| argocd.syncPolicy.selfHeal | bool | `true` | Enable [Argocd self heal](https://argoproj.github.io/argo-cd/user-guide/auto_sync/#automatic-self-healing) |
| cluster.baseURL | string | `""` | Suffix url for ingress access |
| cluster.branch | string | `"master"` | branch name to use |
| cluster.clusterEnv | string | `""` | environment of the cluster |
| cluster.clusterName | string | `""` | Name of the target cluster |
| cluster.env | string | `""` | environment name used to construct url (i.e {alertmanager,grafana,prometheus,dex}.${prefix}.${env}.${baseURL}) |
| cluster.gcpProjectId | string | `""` | GCP Project ID |
| cluster.httpProxy | string | `""` | http_proxy and https_proxy env variable if any |
| cluster.idpRole | string | `""` | IDP role group |
| cluster.idpUrl | string | `""` | URL of the IDP Provider |
| cluster.imagePullSecrets | list | `[]` | Secrets to use to pull images for all infra components. |
| cluster.noProxy | string | `""` | no_proxy env variable |
| cluster.ociRepoUrl | string | `"europe-docker.pkg.dev/irn-71889-adm-dev-ope-68/helm-gke-irn70740"` | URL of the helm repo for Artifact Registry. To be used for migration of helm charts to Artifact Registry |
| cluster.prefix | string | `""` | prefix url for ingress access |


----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
