#!/bin/bash

if [ "$1" = "init" ]; then
    docker-compose build

    exit $?
fi

if [ "$1" = "up" ]; then
    docker-compose up --build

    exit $?
fi

if [ "$1" = "down" ]; then
    docker-compose down

    exit $?
fi

echo "./start.sh COMMAND
        init        - first init remote service
        up          - start remote service
        down        - stop remote service
        clean       - clean remote service
"
