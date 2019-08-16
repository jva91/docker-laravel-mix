# docker-laravel-mix
This setup contains a docker installation tested for Laravel 5.5 + Laravel mix.

## Containers

- app container
- mysql container
- phpmyadmin container
- node container


Node container is running in the background to poll the css and js files.

## Usage

To start this setup use `docker-compose up -d`, this starts all the containers. For Linux and Mac be sure the files in docker/init-scripts have rights to execute. 
These rights need to be set on the host (so not on the docker server), and can be done by executing `chmod -R 0777 docker/init-scripts` in the root of your project

The app and node container contains a entrypoint, this calls an bash script to startup the container. 
This will allow us to override the standard execution of the docker image and adding composer and laravel mix actions.

apache_start.sh

	#!/bin/sh
	set -e

	echo 'running prestart apache script'
	
	echo 'running composer install'
	composer install
	
	php artisan migrate
	
	echo 'initialization done, starting apache'
	exec apache2-foreground

On startup `composer install`, `php artisan migrate` and `apache2-foreground`(starts apache service) are executed when calling `docker-compose up`.

node_start.sh

	#!/bin/sh

	set -e
	
	echo 'running prestart node script'
	echo 'running npm install'
	npm install
	
	echo 'initialization done, start watching'
	npm run watch-poll

When the node image is started `npm install` is executed, after that `npm run watch-poll` is called to continuously run Laravel Mix in the background of the node image.
We are using `npm run watch-poll` because of problems with `npm run watch` not detecting file changes, but you are free to change this offcourse.