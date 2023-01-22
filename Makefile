.PHONY: up down status logs start-local test coverage coverage-features

up:
	docker compose up -d

down:
	docker compose down --remove-orphans

status:
	docker compose ps

logs:
	docker compose logs -f --tail=100 mariadb

start-local:
	uvicorn fastapi_mqtt_server.main:app --reload

test:
ifdef filter
	poetry run pytest $(filter) -vv
else
	poetry run pytest -vv
endif

coverage: test
	poetry run pytest --cov-report term-missing --cov=fastapi_vslice

coverage-features: test
	poetry run pytest --cov-report term-missing --cov=fastapi_vslice/features