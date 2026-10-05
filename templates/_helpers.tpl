{{/*
Common Axion name
*/}}
{{- define "axion.name" -}}
axion
{{- end }}


{{/*
PostgreSQL service name
This name is shared between PostgreSQL and other microservices.
*/}}
{{- define "axion.postgresServiceName" -}}
{{ include "axion.name" . }}-{{ .Release.Name }}-postgres-svc
{{- end }}


{{/*
Ingestion service name
*/}}
{{- define "axion.ingestionServiceName" -}}
{{ include "axion.name" . }}-{{ .Release.Name }}-ingestion-svc
{{- end }}


{{/*
Application namespace
*/}}
{{- define "axion.namespace" -}}
{{ .Release.Namespace }}
{{- end }}

{{/*
Telemetry service URL
*/}}
{{- define "axion.telemetryService" -}}
{{ .Values.global.telemetryServiceUrl }}
{{- end }}



