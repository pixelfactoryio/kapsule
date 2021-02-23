BASE_DOMAIN=pixelfactory.io
HELM = /Users/amine/go/bin/helm-sops
KUBECTL = /usr/local/bin/kubectl

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
ROOT_BUILD_DIR := $(shell dirname $(MKFILE_PATH))
ROOT_BUILD_DIR := $(shell dirname $(MKFILE_PATH))

help: ## Display help
	@echo "Usage:"
	@echo "  make <target> <variables>"
	@echo ""
	@echo "Targets:"
	@sed -n 's/:.*[#]#/:#/p' $(firstword $(MAKEFILE_LIST)) | sort | column -t -c 2 -s ':#' | sed 's/^/  /'
.PHONY: help

acquire-sudo:
	@sudo echo -n
.PHONY: acquire-sudo

kube-context:
	@$(KUBECTL) config use-context ${KUBE_CONTEXT}
.PHONY: kube-context

namespace: kube-context
	@$(KUBECTL) \
		create namespace ${NAMESPACE} \
		--dry-run=client -o yaml | $(KUBECTL) apply -f -
.PHONY: namespace

helm-repo:
	@$(HELM) repo add ${HELM_REPO_NAME} ${HELM_REPO_URL}
	@$(HELM) repo update
.PHONY: helm-repo

helm: kube-context helm-repo
	@$(HELM) upgrade \
  		--install \
  		--namespace ${NAMESPACE} \
		--version ${HELM_CHART_VERSION} \
  		${RELEASE} ${HELM_REPO_NAME}/${HELM_CHART} \
		`[[ ! -z "${HELM_CHART_VALUES}" ]] && echo "--values ${HELM_CHART_VALUES}"` \
		`[[ ! -z "${HELM_CHART_SECRETS}" ]] && echo "--values ${HELM_CHART_SECRETS}"`
.PHONY: helm

certificate: kube-context
	@BASE_DOMAIN=${BASE_DOMAIN} \
	SVC_NAME=${SVC_NAME} \
	envsubst < ${ROOT_BUILD_DIR}/certificate.tpl.yaml | $(KUBECTL) --namespace ${NAMESPACE} apply -f -
.PHONY: traefik-ingressroute

ingressroute: kube-context
	@BASE_DOMAIN=${BASE_DOMAIN} \
	SVC_NAME=${SVC_NAME} \
	SVC_PORT=${SVC_PORT} \
	envsubst < ${ROOT_BUILD_DIR}/ingress.tpl.yaml | $(KUBECTL) --namespace ${NAMESPACE} apply -f -
.PHONY: traefik-ingressroute