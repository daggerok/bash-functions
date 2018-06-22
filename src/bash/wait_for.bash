#!/usr/bin/env bash
# requires binaries: sudo, lsof, wc
# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  echo "waiting for ports: $*"
  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    echo "waiting for port: ${port}"
    while [ $(sudo lsof -t -i:${port} | wc -l) == "0" ]; do sleep 1; done;
    echo "${port} is ready."
    echo "found according PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
