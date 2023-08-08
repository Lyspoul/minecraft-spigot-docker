#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORLDS_DIR="${CURRENT_DIR}/worlds"

IMAGE_NAME="lyspoul/minecraft-spigot-server"

game_mode="survival"

parse_arguments() {
  while [ $# -gt 0 ]; do
    case $1 in
    --world)
      shift
      world="${WORLDS_DIR}/$1"
      ;;
    --mode)
      shift
      game_mode=$1
      ;;
    esac
    shift
  done

  if [[ -z "${world}" ]]; then
    echo "--world must be specified"
    exit 101
  fi
}

setup_world() {
  if [[ ! -d "${world}" ]]; then
    mkdir -p "${world}"
  fi
}

run_server() {
  docker run --rm --name mc -v "${world}":/root/minecraft/world -p 25565:25565 -it "${IMAGE_NAME}" "${game_mode}"
}

parse_arguments $@
setup_world
run_server
