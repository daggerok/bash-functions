#!/usr/bin/env bash
# requires binaries: sudo, lsoft, wc
# helper sudo_wait_for function, usage: `sudo_wait_for 8080 8081`
function sudo_wait_for {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ $(sudo lsof -t -i:${port} | wc -l) == "0" ]; do sleep 1; done
    echo "Port $port is ready. According PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
