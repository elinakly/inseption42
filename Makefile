SRC=srcs
DATA_PATH ?= $(HOME)/data
DOCKER_COMPOSE := $(shell if docker compose version >/dev/null 2>&1; then echo "docker compose"; elif command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; fi)

all: up

check_compose:
	@if [ -z "$(DOCKER_COMPOSE)" ]; then \
		echo "Error: Docker Compose is not available."; \
		echo "Start Docker Desktop with WSL integration enabled, or install Docker Engine + Compose in this distro."; \
		exit 1; \
	fi

build: check_compose
	$(DOCKER_COMPOSE) -f $(SRC)/docker-compose.yml build

up: create_dirs build
	$(DOCKER_COMPOSE) -f $(SRC)/docker-compose.yml up -d

down: check_compose
	$(DOCKER_COMPOSE) -f $(SRC)/docker-compose.yml down

create_dirs:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress

re: down all

.PHONY: all check_compose build up down re create_dirs