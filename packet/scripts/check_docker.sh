#!/bin/bash

sleep 10

count=1

while true; do
    docker ps
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 5
done
echo "Docker running"
