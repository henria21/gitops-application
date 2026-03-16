{{- define "weather-backend.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "weather-backend.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "weather-backend.labels" -}}
app: {{ include "weather-backend.name" . }}
release: {{ .Release.Name }}
{{- end }}
