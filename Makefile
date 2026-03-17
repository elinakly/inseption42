SRC=srcs
DATA_PATH=/home/eklymova/data

all: up

build:
	docker-compose -f $(SRC)/docker-compose.yml build --no-cache

create_dirs:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress

up: create_dirs build
	docker-compose -f $(SRC)/docker-compose.yml up -d

down:
	docker-compose -f $(SRC)/docker-compose.yml down --volumes --remove-orphans

re: down all

.PHONY: all build up down re create_dirs