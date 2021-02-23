
include ../global.mk
NAMESPACE=cert-manager
RELEASE=cert-manager
HELM_REPO_NAME=jetstack
HELM_REPO_URL=https://charts.jetstack.io
HELM_CHART=cert-manager
HELM_CHART_VERSION=v1.2.0
HELM_CHART_VALUES=values.yaml

cluster-issuer-staging:
	@$(KUBECTL) \
		--namespace ${NAMESPACE} \
		apply -f cluster-issuer-staging.yaml
.PHONY: cluster-issuer-staging

cluster-issuer-prod:
	@$(KUBECTL) \
		--namespace ${NAMESPACE} \
		apply -f cluster-issuer-prod.yaml
.PHONY: cluster-issuer-prod

install: namespace helm cluster-issuer-staging cluster-issuer-prod
