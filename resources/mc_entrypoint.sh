#!/bin/bash

WORLD_DIR="/root/minecraft/world"

GAME_MODE="survival"
if [[ $1 ]]; then
  GAME_MODE=$1
fi

if [[ ! -d ${WORLD_DIR} || ! -e "${WORLD_DIR}/server.properties" ]]; then
  echo "World does not exist, creating it"
  mkdir -p "${WORLD_DIR}"
  if [[ ${GAME_MODE} == *"survival"* ]]; then
    cp /root/config/survival_server.properties "${WORLD_DIR}/server.properties"
    else
      cp /root/config/creative_server.properties "${WORLD_DIR}/server.properties"
  fi
  cp /root/config/eula.txt "${WORLD_DIR}"
  else
    echo "Pre-existing world starting up"
fi

jar_name=$(find /root/minecraft/ -maxdepth 1 -regex ".*spigot-.*\.jar")
pushd "${WORLD_DIR}" >> /dev/null &&
java -Xms512M -Xmx1008M -jar "${jar_name}" nogui
