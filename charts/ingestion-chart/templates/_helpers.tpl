
{{/*
Base application name
*/}}
{{- define "ingestion.name" -}}
axion-ingestion
{{- end }}


{{/*
Deployment name
*/}}
{{- define "ingestion.deploymentName" -}}
{{ .Release.Name }}-{{ include "ingestion.name" . }}-deploy
{{- end }}

{{/*
HPA name
*/}}
{{- define "ingestion.hpaName" -}}
{{ .Release.Name }}-{{ include "ingestion.name" . }}-hpa
{{- end }}


{{/*
Service name

{{- define "ingestion.serviceName" -}}
{{ .Release.Name }}-{{ include "ingestion.name" . }}-svc
{{- end }}
*/}}


{{/*
ingress name
*/}}
{{- define "ingestion.ingName" -}}
{{ .Release.Name }}-{{ include "ingestion.name" . }}-ingress
{{- end }}


{{/*
Database connection string
*/}}
{{- define "ingestion.databaseUrl" -}}
postgresql://{{ .Values.database.postgresUser }}:{{ .Values.database.postgresPassword }}@{{ include "axion.postgresServiceName" . }}:{{ .Values.database.port }}/{{ .Values.database.postgresDbName }}
{{- end }}