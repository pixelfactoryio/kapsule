
include ../global.mk
NAMESPACE=traefik
RELEASE=traefik
HELM_REPO_NAME=containous
HELM_REPO_URL=https://helm.traefik.io/traefik
HELM_CHART=traefik
HELM_CHART_VERSION=9.14.2
HELM_CHART_VALUES=values.yaml

secret: kube-context
	@$(KUBECTL) \
		-n ${NAMESPACE} \
		create secret generic traefik-basic-auth --from-file=auth
.PHONY: secret

install: namespace helm secret certificate
