include global.mk

default: help

traefik: ## Install Traefik
	@$(MAKE) --directory=traefik install
.PHONY: traefik

cert-manager: ## Install Cert-Manager
	@$(MAKE) --directory=cert-manager install
.PHONY: cert-manager

grafana: ## Install Grafana
	@$(MAKE) --directory=grafana install
.PHONY: grafana

prometheus: ## Install Prometheus
	@$(MAKE) --directory=prometheus install
.PHONY: prometheus

loki: ## Install Loki
	@$(MAKE) --directory=loki install
.PHONY: loki

