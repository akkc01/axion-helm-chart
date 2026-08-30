
{{/*
Base application name
*/}}
{{- define "axion.name" -}}
axion-telemetry
{{- end }}


{{/*
Deployment name
*/}}
{{- define "telemetry.deploymentName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-deploy
{{- end }}

{{/*
HPA name
*/}}
{{- define "telemetry.hpaName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-hpa
{{- end }}


{{/*
Service name
*/}}
{{- define "telemetry.serviceName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-svc
{{- end }}



{{/*
ingress name
*/}}
{{- define "telemetry.ingName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-ingress
{{- end }}