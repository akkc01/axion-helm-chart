{{/*
Base application name
*/}}
{{- define "axion.name" -}}
axion
{{- end }}


{{/*
Deployment name
*/}}
{{- define "axion.deploymentName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-deploy
{{- end }}


{{/*
Service name
*/}}
{{- define "axion.serviceName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-svc
{{- end }}

{{/*
HPA name
*/}}
{{- define "axion.hpaName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-hpa
{{- end }}


{{/*
ingress name
*/}}
{{- define "axion.ingName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-ingress
{{- end }}