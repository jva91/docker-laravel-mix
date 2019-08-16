#!/bin/sh

set -e

echo 'running prestart apache script'

echo 'running composer install'
composer install

php artisan migrate

echo 'initialization done, starting apache'
exec apache2-foreground