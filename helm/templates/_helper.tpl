{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "infra-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "infra-stack.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "infra-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "infra-stack.labels" -}}
{{- if .Values.apps.istio.enabled -}}
app: {{ include "infra-stack.name" . | quote | trim }}
version: {{ .Chart.AppVersion | quote | trim }}
{{- end -}}
app.kubernetes.io/name: {{ include "infra-stack.name" . }}
helm.sh/chart: {{ include "infra-stack.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "infra-stack.url" -}}
{{ .Values.cluster.prefix }}.{{ .Values.cluster.env }}.{{ .Values.cluster.baseURL }}
{{- end -}}

{{- define "infra-stack.tlsSecret" -}}
{{- if and .Values.cluster.prefix .Values.cluster.env .Values.cluster.baseURL -}}
{{ .Values.cluster.prefix | replace "." "-"  }}-{{ .Values.cluster.env }}-{{ .Values.cluster.baseURL | replace "." "-" }}-tls
{{- else -}}
{{ printf "%s" "infra-stack-tls" }}
{{- end -}}
{{- end -}}

{{- define "alertmanager.url" -}}
{{- if .Values.apps.alertmanager.url -}}
{{ tpl .Values.apps.alertmanager.url . }}
{{- else -}}
{{ printf "%s.%s" "alertmanager" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}}

{{- define "alertmanager.ingressClass" -}}
{{ .Values.apps.alertmanager.ingressClass | default "nginx-internal" }}
{{- end -}}

{{- define "alertmanager.namespace" -}}
{{ .Values.apps.alertmanager.namespace | default "monitoring" }}
{{- end -}}


{{- define "alertmanager.tlsSecret" -}}
{{ toYaml .Values.apps.alertmanager.tlsSecret }}
{{- end -}}

{{- define "alertmanager.oidcGroupRw" -}}
{{ toYaml  .Values.apps.alertmanager.oidcGroupRw }}
{{- end -}}

{{- define "alertmanager.oidcGroupRo" -}}
{{ toYaml  .Values.apps.alertmanager.oidcGroupRo }}
{{- end -}}


{{- define "karma.url" -}}
{{- if .Values.apps.karma.url -}}
{{ tpl .Values.apps.karma.url . }}
{{- else -}}
{{ printf "%s.%s" "karma" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}}

{{- define "karma.ingressClass" -}}
{{ .Values.apps.karma.ingressClass | default "nginx-internal" }}
{{- end -}}

{{- define "karma.appproject" -}}
{{ .Values.apps.karma.appproject | default "karma" }}
{{- end -}}

{{- define "karma.namespace" -}}
{{ .Values.apps.karma.namespace | default "karma-system" }}
{{- end -}}

{{- define "dex.url" -}}
{{- if .Values.apps.dex.url -}}
{{ tpl .Values.apps.dex.url . }}
{{- else -}}
{{ printf "%s.%s" "dex" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}}

{{- define "dex.ingressClass" -}}
{{ .Values.apps.dex.ingressClass | default "nginx-internal" }}
{{- end -}}

{{- define "dex.tlsSecret" -}}
{{ toYaml .Values.apps.dex.tlsSecret }}
{{- end -}}

{{- define "dex.namespace" -}}
{{ .Values.apps.dex.namespace | default "monitoring" }}
{{- end -}}

{{- define "dex.dexConnectors" -}}
{{ toYaml .Values.apps.dex.dexConnectors }}
{{- end -}}


{{- define "grafana.namespace" -}}
{{ .Values.apps.grafana.namespace | default "monitoring" }}
{{- end -}}

{{- define "grafana.url" -}}
{{- if .Values.apps.grafana.url -}}
{{ tpl .Values.apps.grafana.url . }}
{{- else -}}
{{ printf "%s.%s" "grafana" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}}

{{- define "grafana.ingressClass" -}}
{{ .Values.apps.grafana.ingressClass | default "nginx-internal" }}
{{- end -}}

{{- define "grafana.tlsSecret" -}}
{{ toYaml .Values.apps.grafana.tlsSecret }}
{{- end -}}

{{- define "prometheus-operator.namespace" -}}
{{ .Values.apps.prometheusOperator.namespace | default "monitoring" }}
{{- end -}}

{{- define "prometheus.namespace" -}}
{{ .Values.apps.prometheus.namespace | default "monitoring" }}
{{- end -}}


{{- define "prometheus.label" -}}
{{ .Values.apps.prometheus.promLabel | default "prometheus-operator-prometheus" }}
{{- end -}}


{{- define "prometheus.url" -}}
{{- if .Values.apps.prometheus.url -}}
{{ tpl .Values.apps.prometheus.url . }}
{{- else -}}
{{ printf "%s.%s" "prometheus" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}}

{{- define "prometheus.ingressClass" -}}
{{ .Values.apps.prometheus.ingressClass | default "nginx-internal" }}
{{- end -}}

{{- define "prometheus.tlsSecret" -}}
{{ toYaml .Values.apps.prometheus.tlsSecret }}
{{- end -}}

{{- define "prometheus.externalLabels" -}}
{{ toYaml .Values.apps.prometheus.externalLabels }}
{{- end -}}

{{- define "prometheus.oidcGroupRw" -}}
{{ toYaml .Values.apps.prometheus.oidcGroupRw }}
{{- end -}}

{{- define "prometheus.oidcGroupRo" -}}
{{ toYaml  .Values.apps.prometheus.oidcGroupRo }}
{{- end -}}

{{- define "kubed.namespace" -}}
{{ .Values.apps.kubed.namespace | default "kubed" }}
{{- end -}}

{{- define "velero.namespace" -}}
{{ .Values.apps.velero.namespace | default "velero" }}
{{- end -}}

{{- define "velero.bucket" -}}
{{ .Values.apps.velero.bucket | default "velero-bkp-bucket" }}
{{- end -}}

{{- define "cert-manager.namespace" -}}
{{ .Values.apps.certManager.namespace | default "cert-manager" }}
{{- end -}}

{{- define "gatekeeper.namespace" -}}
{{ .Values.apps.gatekeeper.namespace | default "gatekeeper-system" }}
{{- end -}}

{{- define "vaultAgent.namespace" -}}
{{ .Values.apps.vaultAgent.namespace | default "vault-agent-injector" }}
{{- end -}}

{{- define "nginx-ingress.namespace" -}}
{{ .Values.apps.nginxIngress.namespace | default "nginx-ingress-controller" }}
{{- end -}}

{{- define "gke-gateway.namespace" -}}
{{ .Values.apps.gkeGateway.namespace | default "gke-gateways" }}
{{- end -}}


{{- define "cert-manager.cert" -}}
{{- if .Values.apps.certManager.mainCert -}}
{{ .Values.apps.certManager.mainCert | replace "." "-" }}
{{- else -}}
{{ printf "%s" "infra-stack-cert" }}
{{- end -}}
{{- end -}}

{{- define "cert-manager.cert.namespace" -}}
{{ .Values.apps.certManager.mainCertNamespace | default "cert-manager" }}
{{- end -}}

{{- define "dynatrace.namespace" -}}
{{ .Values.apps.oneAgentOperator.namespace | default "dynatrace" }}
{{- end -}}

{{- define "argocd.namespace" -}}
{{ .Values.apps.argocd.namespace | default "argocd" }}
{{- end -}}

{{- define "argocd.url" -}}
{{- if .Values.apps.argocd.url -}}
{{ tpl .Values.apps.argocd.url . }}
{{- else -}}
{{ printf "%s.%s" "argocd" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}} 

{{- define "goldilocks.namespace" -}}
{{ .Values.apps.goldilocks.namespace | default "goldilocks" }}
{{- end -}}

{{- define "goldilocks.url" -}}
{{- if .Values.apps.goldilocks.url -}}
{{ tpl .Values.apps.goldilocks.url . }}
{{- else -}}
{{ printf "%s.%s" "goldilocks" ( include "infra-stack.url" . ) }}
{{- end -}}
{{- end -}}

{{- define "goldilocks.ingressClass" -}}
{{ .Values.apps.goldilocks.dashboard.ingressClass | default "nginx-internal" }}
{{- end -}}

{{- define "goldilocks.oidcGroupRo" -}}
{{- $list := list }}
{{- range .Values.apps.goldilocks.oauth2Proxy.oidcGroupRo }}
{{- $list = append $list (printf "\"%s\"" .) }}
{{- end }}
{{- join ", " $list }}
{{- end }}


{{- define "external-secret-operator.namespace" -}}
{{ .Values.apps.externalSecretsOperator.namespace | default "external-secrets-operator" }}
{{- end -}}

{{- define "msteams.namespace" -}}
{{ .Values.apps.msteams.namespace | default "monitoring" }}
{{- end -}}

{{- define "crossplane.namespace" -}}
{{ .Values.apps.crossplane.namespace | default "crossplane-system" }}
{{- end -}}

{{- define "alertmanager.appproject" -}}
{{ .Values.apps.alertmanager.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "argocd.appproject" -}}
{{ .Values.apps.argocd.appproject | default "argocd-by-argocd" }}
{{- end -}}

{{- define "cert-manager.appproject" -}}
{{ .Values.apps.certManager.appproject | default "cert-manager" }}
{{- end -}}

{{- define "crossplane.appproject" -}}
{{ .Values.apps.crossplane.appproject | default "crossplane" }}
{{- end -}}

{{- define "dex.appproject" -}}
{{ .Values.apps.dex.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "dynatrace.appproject" -}}
{{ .Values.apps.oneAgentOperator.appproject | default "dynatrace" }}
{{- end -}}

{{- define "external-secrets.appproject" -}}
{{ .Values.apps.externalSecrets.appproject | default "external-secrets" }}
{{- end -}}

{{- define "external-secrets-operator.appproject" -}}
{{ .Values.apps.externalSecretsOperator.appproject | default "external-secrets" }}
{{- end -}}

{{- define "gatekeeper.appproject" -}}
{{ .Values.apps.gatekeeper.appproject | default "gatekeeper" }}
{{- end -}}

{{- define "goldilocks.appproject" -}}
{{ .Values.apps.goldilocks.appproject | default "goldilocks" }}
{{- end -}}

{{- define "grafana.appproject" -}}
{{ .Values.apps.grafana.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "kubed.appproject" -}}
{{ .Values.apps.kubed.appproject | default "kubed" }}
{{- end -}}

{{- define "msteams.appproject" -}}
{{ .Values.apps.msteams.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "prometheus-operator.appproject" -}}
{{ .Values.apps.prometheusOperator.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "prometheus.appproject" -}}
{{ .Values.apps.prometheus.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "vault-agent-injector.appproject" -}}
{{ .Values.apps.vaultAgent.appproject | default "vault-agent-injector" }}
{{- end -}}

{{- define "velero.appproject" -}}
{{ .Values.apps.velero.appproject | default "velero" }}
{{- end -}}

{{- define "mirrorregistry.namespace" -}}
{{ .Values.apps.mirrorregistry.namespace | default "mirror-registry-system" }}
{{- end -}}

{{- define "mirrorregistry.appproject" -}}
{{ .Values.apps.mirrorregistry.appproject | default "mirror-registry" }}
{{- end -}}

{{- define "starboardOperator.namespace" -}}
{{ .Values.apps.starboardOperator.namespace | default "starboard-operator" }}
{{- end -}}

{{- define "starboardOperator.appproject" -}}
{{ .Values.apps.starboardOperator.appproject | default "starboard-operator" }}
{{- end -}}

{{- define "starboardExporter.namespace" -}}
{{ .Values.apps.starboardExporter.namespace | default "starboard-exporter" }}
{{- end -}}

{{- define "starboardExporter.appproject" -}}
{{ .Values.apps.starboardExporter.appproject | default "starboard-exporter" }}
{{- end -}}

{{- define "trivyOperator.appproject" -}}
{{ .Values.apps.trivyOperator.appproject | default "trivy-operator" }}
{{- end -}}
{{- define "trivyOperator.namespace" -}}
{{ .Values.apps.trivyOperator.namespace | default "trivy-system" }}
{{- end -}}

{{- define "blackboxExporter.namespace" -}}
{{ .Values.apps.blackboxExporter.namespace | default "monitoring" }}
{{- end -}}

{{- define "blackboxExporter.appproject" -}}
{{ .Values.apps.blackboxExporter.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "dynaKubeOperator.namespace" -}}
{{ .Values.apps.dynaKubeOperator.namespace | default "dynakube-operator" }}
{{- end -}}

{{- define "dynaKubeOperator.appproject" -}}
{{ .Values.apps.dynaKubeOperator.appproject | default "dynakube-operator" }}
{{- end -}}

{{- define "stackdriverExporter.namespace" -}}
{{ .Values.apps.stackdriverExporter.namespace | default "monitoring" }}
{{- end -}}

{{- define "stackdriverExporter.appproject" -}}
{{ .Values.apps.stackdriverExporter.appproject | default "kube-prometheus" }}
{{- end -}}

{{- define "configConnectorOperator.namespace" -}}
{{ .Values.apps.configConnectorOperator.namespace | default "configconnector-operator-system" }}
{{- end -}}

{{- define "configConnectorOperator.appproject" -}}
{{ .Values.apps.configConnectorOperator.appproject | default "configconnector-operator" }}
{{- end -}}

{{- define "configConnector.namespace" -}}
{{ .Values.apps.configConnector.namespace | default "configconnector-operator-system" }}
{{- end -}}

{{- define "configConnector.appproject" -}}
{{ .Values.apps.configConnector.appproject | default "configconnector" }}
{{- end -}}

{{- define "configConnectorContext.namespace" -}}
{{ .Values.cluster.cnrmNamespace | default "cnrm-gcp-infra" }}
{{- end -}}

{{- define "configConnectorContext.appproject" -}}
{{ .Values.apps.configConnectorContext.appproject | default "configconnector-context" }}
{{- end -}}

{{- define "infra.syncPolicy" -}}
{{- $dot := index . 0 -}}
{{- $apps := index . 1 -}}
{{- $appvalues := index $dot.Values.apps $apps -}}
{{- if and ( not $appvalues.syncPolicy.disableAuto ) $dot.Values.argocd.syncPolicy.auto -}}
syncPolicy:
  automated:
    prune: {{ if and ( not $appvalues.syncPolicy.disablePrune ) $dot.Values.argocd.syncPolicy.prune }}true{{ else }}false{{ end }}
    selfHeal: {{ if and ( not $appvalues.syncPolicy.disableSelfHeal ) $dot.Values.argocd.syncPolicy.selfHeal }}true{{ else }}false{{ end }}
  {{- if $dot.Values.argocd.syncPolicy.retry }}
  retry:
    limit: {{ $dot.Values.argocd.syncPolicy.retry.limit }}
    backoff:
      duration: {{ $dot.Values.argocd.syncPolicy.retry.backoff.duration }}
      maxDuration: {{ $dot.Values.argocd.syncPolicy.retry.backoff.maxDuration }}
      factor: {{ $dot.Values.argocd.syncPolicy.retry.backoff.factor }}
  {{- end }}
  {{- end -}}
{{- end -}}
