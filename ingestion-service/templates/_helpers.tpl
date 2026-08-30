
{{/*
Base application name
*/}}
{{- define "axion.name" -}}
axion
{{- end }}


{{/*
Deployment name
*/}}
{{- define "ingestion.deploymentName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-deploy
{{- end }}

{{/*
HPA name
*/}}
{{- define "ingestion.hpaName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-hpa
{{- end }}


{{/*
Service name
*/}}
{{- define "ingestion.serviceName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-svc
{{- end }}



{{/*
ingress name
*/}}
{{- define "ingestion.ingName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-ingress
{{- end }}