up: docker-up
down: docker-down
restart: docker-down docker-up
init: docker-down-clear api-clear docker-pull docker-build docker-up api-init

#init: docker-clear docker-up api-permissions api-env api-composer api-genrsa pause api-migration api-fixtures frontend-env frontend-install frontend-build storage-permissions websocket-env websocket-key websocket-install websocket-start

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

#api-init: api-composer-install api-assets-install api-wait-db api-migrations api-fixtures api-ready
api-init: api-composer-install api-wait-db api-ready

api-clear:
	docker run --rm -v ${PWD}/api:/app --workdir=/app alpine rm -f .ready

api-composer-install:
	docker-compose run --rm api-php-cli composer install

api-wait-db:
	until docker-compose exec -T api-postgres pg_isready --timeout=0 --dbname=app ; do sleep 1 ; done

#api-migrations:
#	docker-compose run --rm api-php-cli php bin/console doctrine:migrations:migrate --no-interaction
#
#api-fixtures:
#	docker-compose run --rm api-php-cli php bin/console doctrine:fixtures:load --no-interaction

api-ready:
	docker run --rm -v ${PWD}/api:/app --workdir=/app alpine touch .ready

#api-test:
#	docker-compose run --rm api-php-cli php bin/phpunit

#frontend-init: frontend-install frontend-build
#
##frontend-env:
##	docker-compose exec frontend-nodejs rm -f .env.local
##	docker-compose exec frontend-nodejs ln -sr .env.local.example .env.local
#
#frontend-install:
#	docker-compose exec frontend-nodejs npm install
#
#frontend-build:
#	docker-compose exec frontend-nodejs npm run build
