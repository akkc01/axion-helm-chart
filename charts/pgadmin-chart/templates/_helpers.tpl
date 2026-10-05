{{/*
Base application name
*/}}
{{- define "pgadm.name" -}}
axion
{{- end }}


{{/*
pgadmin name
*/}}
{{- define "pgadmin.name" -}}
pgadmin
{{- end }}


{{/*
pgadmin Deployment name
*/}}
{{- define "pgadmin.deploymentName" -}}
{{ .Release.Name }}-{{ include "pgadm.name" . }}-{{ include "pgadmin.name" . }}-deploy
{{- end }}


{{/*
pgadmin Service name
*/}}
{{- define "pgadmin.serviceName" -}}
{{ include "pgadm.name" . }}-{{ .Release.Name }}-{{ include "pgadmin.name" . }}-svc
{{- end }}


{{/*
pgadmin Secret name
*/}}
{{- define "pgadmin.secretName" -}}
{{ include "pgadm.name" . }}-{{ .Release.Name }}-{{ include "pgadmin.name" . }}-secret
{{- end }}


{{/*
pgadmin Ingress name
*/}}
{{- define "pgadmin.ingName" -}}
{{ include "pgadm.name" . }}-{{ .Release.Name }}-{{ include "pgadmin.name" . }}-ingress
{{- end }}