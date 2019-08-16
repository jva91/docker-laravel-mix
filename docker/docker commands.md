**Handige commando's voor deze install:**

Eerste keer:

`docker-compose build`


`docker-compose run -u 1000:1000 oc composer install`


`docker-compose run -u 1000:1000 oc php artisan migrate`


`docker-compose run -u 1000:1000 oc php artisan db:seed`

Docker image aanzetten:

`docker-compose up -d`

Docker image uitzetten

`docker-compose down`

Als user inloggen op de docker image:

`docker-compose exec -u 1000:1000 oc bash`


**Algemene commands**

[https://docs.docker.com/machine/drivers/hyper-v/#example](https://docs.docker.com/machine/drivers/hyper-v/#example "hyper-v on win10 pro")


docker machine maken


    docker-machine create -d hyperv --hyperv-virtual-switch "Primary Virtual Switch" manager1

om je container te builden:

    docker build -t docker-laravel -f docker/Dockerfile .

dit project heet docker-laravel

om je container te runnen en bash uit te voeren:

    docker run --rm -it docker-laravel bash


voor runnen van container

    docker run --rm -d docker-laravel
    
Voor mappen localhost 8080 naar 80 in de docker container

    docker run --rm -d -p 8080:80 docker-laravel
   

met ps kun je de runnende containers zien

    docker ps

om code uit een werkende container te halen (d1 is een container id je hoeft alleen de eerste paar karakters te geven)

    docker cp d1:/etc/apache2/sites-available/000-default.conf docker/vhost.conf
    
Om docker containter te stoppen 
    
    docker stop d1
    
om elke running container te stoppen

    docker stop $(docker ps -aq)
    
docker via docker-compose.yml runnen
    
    docker-compose up -d
    
als na dit commando geen docker container draait dan 

    docker-compose up -d --build
    
bij een error zoals hieronder moet je docker restarten

    ERROR: for app  Cannot start service app: driver failed programming external connectivity on endpoint laravel-www (3d1977df6fe8f
    e39d28bbfef49d57a6c2653fa13028b4bb8c0ab8295d5eaad69): Error starting userland proxy: mkdir /port/tcp:0.0.0.0:8080:tcp:172.18.0.2
    :80: input/output error
    
via docker compose je container in

    docker-compose exec app /bin/bash
    
docker compose sluiten

    docker-compose down
    
Eenmalig in je container een commando uitvoeren en weer sluiten
    
    docker-compose run --rm app php artisan --version


    
