COMPOSE_YML := srcs/docker-compose.yml

all:
	docker compose -f srcs/docker-compose.yml up --build -d

clean:
	docker compose -f srcs/docker-compose.yml down

fclean:
	docker compose -f srcs/docker-compose.yml down
	docker compose -f srcs/docker-compose.yml down --volumes

re:
	@make -s fclean
	@make -s all
