{{/*
Base application name
*/}}
{{- define "postgres.name" -}}
postgres
{{- end }}

{{/*
Base application name
*/}}
{{- define "pgres.name" -}}
axion
{{- end }}

{{/*
PostgreSQL Deployment name
*/}}
{{- define "postgres.deploymentName" -}}
{{ .Release.Name }}-{{ include "pgres.name" . }}-{{ include "postgres.name" . }}-deploy
{{- end }}


{{/*
PostgreSQL Service name

IMPORTANT:
Use the common parent helper so every chart knows
the exact PostgreSQL service name.
*/}}
{{- define "postgres.serviceName" -}}
{{ include "axion.postgresServiceName" . }}
{{- end }}


{{/*
PostgreSQL Secret name
*/}}
{{- define "postgres.secretName" -}}
{{ include "pgres.name" . }}-{{ .Release.Name }}-{{ include "postgres.name" . }}-secret
{{- end }}


{{/*
PostgreSQL ConfigMap name
*/}}
{{- define "postgres.configMapName" -}}
{{ include "pgres.name" . }}-{{ .Release.Name }}-{{ include "postgres.name" . }}-configmap
{{- end }}