# docker-laravel-mix
This setup contains a docker installation tested for Laravel 5.5 + Laravel mix.

## Containers

- app container
- mysql container
- phpmyadmin container
- node container


Node container is running in the background to poll the css and js files.

## Usage

To start this setup `docker-compose up -d`, this starts all the containers. For Linux and Mac be sure the files in docker/init-scripts have rights to execute. This rights need to be set on the host.

The app and node container contains a entrypoint, this calls an bash script to startup the container.

apache_start.sh

	#!/bin/sh
	set -e

	echo 'running prestart apache script'
	
	echo 'running composer install'
	composer install
	
	php artisan migrate
	
	echo 'initialization done, starting apache'
	exec apache2-foreground

When startup `composer install` and `php artisan migrate`  is always executed when calling `docker-compose up` and apache is starting

node_start.sh

	#!/bin/sh

	set -e
	
	echo 'running prestart node script'
	echo 'running npm install'
	npm install
	
	echo 'initialization done, start watching'
	npm run watch-poll

When startup `npm install` is executed and start watching the css and js files.
