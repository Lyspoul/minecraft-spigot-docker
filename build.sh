#!/bin/bash

image_name="lyspoul/minecraft-spigot-server"

tag=latest
if [[ $1 ]]; then
  tag=$1
fi

docker build -t "${image_name}:${tag}" .
