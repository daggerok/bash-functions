#!/usr/bin/env bash
# requires binaries: docker, wc, sleep
# helper wait_healthy_docker_containers function
# usage:
#   wait_healthy_docker_containers
#   wait_healthy_docker_containers 1
#   wait_healthy_docker_containers 3
function wait_healthy_docker_containers {
  n=${1:-1} ;
  while [[ $(docker ps -n ${n} -q -f health=healthy -f status=running | wc -l) -lt ${n} ]] ; do
    sleep 1s ;
    echo -ne '.' ;
  done ;
  echo '' ;
}
