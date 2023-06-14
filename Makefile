.PHONY: setup run

setup:
	docker compose run app bundle exec rails db:create db:migrate

run:
	docker compose up
