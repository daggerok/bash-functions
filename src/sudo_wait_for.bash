#!/usr/bin/env bash
# requires binaries: sudo, lsoft, wc
# helper sudo_wait_for function, usage: `sudo_wait_for 8080 8081`
function sudo_wait_for {
  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ "$(sudo lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done
    echo "$port is ready."
    echo "found according PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
