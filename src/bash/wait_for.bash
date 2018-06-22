#!/usr/bin/env bash
# requires binaries: sudo, lsof, wc
# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  for port in "$*"; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ "$(sudo lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "${port} is ready."
    echo "found according PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
