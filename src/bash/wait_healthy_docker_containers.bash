#!/usr/bin/env bash
# requires binaries: docker, wc, sleep
# helper wait_healthy_docker_containers function
# usage:
#   wait_healthy_docker_containers
#   wait_healthy_docker_containers 1
#   wait_healthy_docker_containers 3
function wait_healthy_docker_containers() {
  n=${1:-1} ;

  # Verify required binaries are present
  required_bins=(docker wc sleep)
  for bin in "${required_bins[@]}"; do
    if ! command -v "$bin" >/dev/null 2>&1; then
      echo "Error: required binary '$bin' is not installed." >&2
      echo "Please install it using your package manager." >&2
      return 1 2>/dev/null || exit 1
    fi
  done

  while [[ $(docker ps -n ${n} -q -f health=healthy -f status=running | wc -l) -lt ${n} ]] ; do
    sleep 1s ;
    echo -ne '.' ;
  done ;
  echo '' ;
}
