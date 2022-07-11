#!/bin/bash

printf "\nBuilding NGINX Docker Image\n"
docker build . -t nginx_docker

if [ ! -f "dist/docker-compose.yml" ]; then
    printf "\nCopying docker-compose.yml file\n"
    cp src/docker-compose.yml dist/docker-compose.yml
fi

printf "\nComplete. Browse to 'dist' directory and execute 'run.sh' file\n"
