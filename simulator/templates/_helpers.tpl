
{{/*
Base application name
*/}}
{{- define "axion.name" -}}
axion
{{- end }}


{{/*
Deployment name
*/}}
{{- define "simulator.deploymentName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-deploy
{{- end }}
