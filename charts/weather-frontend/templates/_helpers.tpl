{{- define "weather-frontend.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "weather-frontend.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "weather-frontend.labels" -}}
app: {{ include "weather-frontend.name" . }}
release: {{ .Release.Name }}
{{- end }}
