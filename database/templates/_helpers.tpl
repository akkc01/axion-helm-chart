
{{/*
Base application name
*/}}
{{- define "axion.name" -}}
axion
{{- end }}

{{/*
pgadmin name
*/}}
{{- define "pgadmin.name" -}}
pgadmin
{{- end }}

{{/*
postgres name
*/}}
{{- define "postgres.name" -}}
postgres
{{- end }}


{{/*
postgress Deployment name
*/}}
{{- define "postgres.deploymentName" -}}
{{ include "postgres.name" . }}-{{ .Release.Name }}-{{ include "axion.name" . }}-deploy
{{- end }}


{{/*
pgadmin Deployment name
*/}}
{{- define "pgadmin.deploymentName" -}}
{{ include "pgadmin.name" . }}-{{ .Release.Name }}-{{ include "axion.name" . }}-deploy
{{- end }}



{{/*
pgadmin Service name
*/}}
{{- define "pgadmin.serviceName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-{{ include "pgadmin.name" . }}-svc
{{- end }}


{{/*
postgres Service name
*/}}
{{- define "postgres.serviceName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-{{ include "postgres.name" . }}-svc
{{- end }}



{{/*
Secret name
*/}}
{{- define "db.secretName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-secrets
{{- end }}


{{/*
ingress name
*/}}
{{- define "db.ingName" -}}
{{ .Release.Name }}-{{ include "axion.name" . }}-ingress
{{- end }}