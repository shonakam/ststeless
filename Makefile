UNAME		= $(uname -a)
NAME		:= stateless
# STACK_NAME  := $(NAME)

TOOLS_DIR	:= tools
CERT_DIR	:= .secret
CERT_NAME	= $(NAME)



up:
	@docker compose up -d --build --scale application=3

down:
	@docker compose down -v

mkcert-install:
	@echo "==> Installing mkcert"
	@bash $(TOOLS_DIR)/install-mkcert.sh

cert:
	@echo "==> Generating certificates"
	@mkdir -p $(CERT_DIR)
	@bash $(TOOLS_DIR)/certs.sh $(CERT_DIR) $(CERT_NAME)

ssl: mkcert-install cert
	@echo "==> SSL ready"

shell-application:
	@docker compose exec -it application bash

inspect-net:
	@docker network inspect stateless-net

# deploy:
# 	@docker info | grep -q "Swarm: active" || docker swarm init
# 	@docker stack deploy -c compose.yml $(STACK_NAME)

# undeploy:
# 	@echo "==> Removing stack $(STACK_NAME)"
# 	@docker stack rm $(STACK_NAME)
# 	@echo "==> Leaving swarm"
# 	@docker swarm leave --force
