{{/*
Base application name
*/}}
{{- define "telemetry.name" -}}
axion
{{- end }}

{{/*
Base application name
*/}}
{{- define "axion.telemetryName" -}}
telemetry
{{- end }}



{{/*
Deployment name
*/}}
{{- define "telemetry.deploymentName" -}}
{{ .Release.Name }}-{{ include "telemetry.name" . }}-deployment
{{- end }}


{{/*
HPA name
*/}}
{{- define "telemetry.hpaName" -}}
{{ .Release.Name }}-{{ include "telemetry.name" . }}-hpa
{{- end }}


{{/*
Service name
*/}}
{{- define "telemetry.serviceName" -}}
{{ include "telemetry.name" . }}-{{ .Release.Name }}-{{ include "axion.telemetryName" . }}-svc
{{- end }}


{{/*
Ingress name
*/}}
{{- define "telemetry.ingName" -}}
{{ .Release.Name }}-{{ include "telemetry.name" . }}-ingress
{{- end }}


{{/*
Database connection string
*/}}
{{- define "telemetry.databaseUrl" -}}
postgresql://{{ .Values.database.postgresUser }}:{{ .Values.database.postgresPassword }}@{{ include "axion.postgresServiceName" . }}:{{ .Values.database.port }}/{{ .Values.database.postgresDbName }}
{{- end }}