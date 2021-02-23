include ../global.mk
NAMESPACE=observability
RELEASE=grafana
HELM_REPO_NAME=grafana
HELM_REPO_URL=https://grafana.github.io/helm-charts
HELM_CHART=grafana
HELM_CHART_VERSION=6.4.2
HELM_CHART_VALUES=values.yaml
HELM_CHART_SECRETS=secrets.enc.yaml
SVC_NAME=grafana
SVC_PORT=80

install: namespace helm certificate ingressroute
