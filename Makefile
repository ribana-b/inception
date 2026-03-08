COMPOSE_YML := srcs/docker-compose.yml

all:
	mkdir -p /home/ribana-b/data
	docker compose -f srcs/docker-compose.yml up --build -d

clean:
	docker compose -f srcs/docker-compose.yml down

fclean:
	docker compose -f srcs/docker-compose.yml down --volumes
	sudo rm -rf /home/ribana-b/data

re:
	@make -s fclean
	@make -s all
