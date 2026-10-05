{{/*
Base application name
*/}}
{{- define "simulator.name" -}}
simulator
{{- end }}



{{/*
Deployment name
*/}}
{{- define "simulator.deploymentName" -}}
{{ .Release.Name }}-{{ include "simulator.name" . }}-deploy
{{- end }}


{{/*
Ingestion API URL

{{- define "simulator.ingestionApiUrl" -}}
http://{{ include "axion.ingestionServiceName" . }}.{{ .Release.Namespace }}.svc.cluster.local:80/api/v1/telemetry/ingest
{{- end }}
*/}}

Ingestion API URL
*/}}
{{- define "simulator.ingestionApiUrl" -}}
http://{{ include "axion.ingestionServiceName" . }}:80/api/v1/telemetry/ingest
{{- end }}


