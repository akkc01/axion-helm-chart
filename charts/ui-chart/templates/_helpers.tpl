{{/*
Base application name
*/}}
{{- define "axion.name" -}}
axion
{{- end }}

{{/*
Base application name
*/}}
{{- define "axion.uiName" -}}
ui
{{- end }}


{{/*
Deployment name
*/}}
{{- define "axion.deploymentName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-{{ include "axion.uiName" . }}-deployment
{{- end }}


{{/*
Service name
*/}}
{{- define "axion.serviceName" -}}
{{ include "axion.name" . }}-{{ .Release.Name }}-{{ include "axion.uiName" . }}-svc
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