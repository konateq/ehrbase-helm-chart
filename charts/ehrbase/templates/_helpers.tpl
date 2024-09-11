{{/*
Expand the name of the chart.
*/}}
{{- define "ehrbase.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ehrbase.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ehrbase.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ehrbase.labels" -}}
helm.sh/chart: {{ include "ehrbase.chart" . }}
{{ include "ehrbase.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ehrbase.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ehrbase.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ehrbase.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ehrbase.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the fully qualified name of the PostgreSQL dependency
*/}}
{{- define "ehrbase.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
{{- end -}}

{{/*
Return the database URL
*/}}
{{- define "ehrbase.databaseUrl" -}}
{{- printf "jdbc:postgresql://%s:%s/%s" (include "ehrbase.databaseHost" .) (include "ehrbase.databasePort" .) (include "ehrbase.databaseName" .) -}}
{{- end -}}

{{/*
Return the database host
*/}}
{{- define "ehrbase.databaseHost" -}}
{{- if eq .Values.postgresql.architecture "replication" }}
{{- ternary (include "ehrbase.postgresql.fullname" .) (tpl .Values.externalDatabase.host $) .Values.postgresql.enabled -}}-primary
{{- else -}}
{{- ternary (include "ehrbase.postgresql.fullname" .) (tpl .Values.externalDatabase.host $) .Values.postgresql.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the database port
*/}}
{{- define "ehrbase.databasePort" -}}
{{- ternary 5432 .Values.externalDatabase.port .Values.postgresql.enabled -}}
{{- end -}}

{{/*
Return the database name
*/}}
{{- define "ehrbase.databaseName" -}}
{{- if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.database -}}
{{- else -}}
{{- .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the database user
*/}}
{{- define "ehrbase.databaseUser" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.username -}}
{{- else -}}
{{- .Values.externalDatabase.username -}}
{{- end -}}
{{- end -}}

{{/*
Return the database secret name
*/}}
{{- define "ehrbase.databaseSecretName" -}}
{{- if .Values.postgresql.enabled -}}
{{- default (include "ehrbase.postgresql.fullname" .) .Values.postgresql.auth.existingSecret -}}
{{- else -}}
{{- default (printf "%s-externaldb" (include "ehrbase.fullname" .)) .Values.externalDatabase.existingSecret -}}
{{- end -}}
{{- end -}}

{{/*
Return the database password key
*/}}
{{- define "ehrbase.databaseSecretPasswordKey" -}}
{{- if .Values.postgresql.enabled -}}
{{- default "password" .Values.postgresql.auth.secretKeys.userPasswordKey -}}
{{- else -}}
{{- default "password" .Values.externalDatabase.existingSecretPasswordKey -}}
{{- end -}}
{{- end -}}

{{/*
Return the basic authentication secret name
*/}}
{{- define "ehrbase.authSecretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
{{- else }}
{{- printf "%s-auth-secret" (include "ehrbase.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return the fully qualified name of the Redis dependency
*/}}
{{- define "ehrbase.redis.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "redis" "chartValues" .Values.redis "context" $) -}}
{{- end -}}

{{/*
Return the Redis host
*/}}
{{- define "ehrbase.redisHost" -}}
{{- if .Values.redis.enabled }}
{{- printf "%s-master" (include "ehrbase.redis.fullname" .) -}}
{{- else -}}
{{- .Values.externalRedis.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis port
*/}}
{{- define "ehrbase.redisPort" -}}
{{- if .Values.redis.enabled }}
{{- .Values.redis.master.service.ports.redis -}}
{{- else -}}
{{- .Values.externalRedis.port -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis secret name
*/}}
{{- define "ehrbase.redisSecretName" -}}
{{- if .Values.redis.enabled }}
{{- if .Values.redis.auth.existingSecret }}
{{- .Values.redis.auth.existingSecret -}}
{{- else -}}
{{- printf "%s" (include "ehrbase.redis.fullname" .) }}
{{- end -}}
{{- else if .Values.externalRedis.existingSecret }}
{{- .Values.externalRedis.existingSecret -}}
{{- else -}}
{{- printf "%s-redis" (include "ehrbase.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis password key
*/}}
{{- define "ehrbase.redisSecretPasswordKey" -}}
{{- if and .Values.redis.enabled .Values.redis.auth.existingSecret }}
{{- .Values.redis.auth.existingSecretPasswordKey }}
{{- else if and (not .Values.redis.enabled) .Values.externalRedis.existingSecret }}
{{- default "redis-password" .Values.externalRedis.existingSecretPasswordKey }}
{{- else -}}
{{- printf "redis-password" -}}
{{- end -}}
{{- end -}}
