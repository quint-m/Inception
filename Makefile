COMPOSE_FILE = srcs/docker-compose.yml
DOCKER_COMPOSE = docker compose -f $(COMPOSE_FILE)

all: build up

up:
	$(DOCKER_COMPOSE) up

down:
	$(DOCKER_COMPOSE) down

build:
	$(DOCKER_COMPOSE) build

re: clean
	$(DOCKER_COMPOSE) build --no-cache
	$(DOCKER_COMPOSE) up --force-recreate

logs:
	$(DOCKER_COMPOSE) logs -f

status:
	$(DOCKER_COMPOSE) ps

clean:
	$(DOCKER_COMPOSE) down -v --remove-orphans
	sudo rm -rf /home/qmennen/data/mariadb_data/*
	sudo rm -rf /home/qmennen/data/wordpress_data/*

.PHONY: all up down build re logs clean