#!/usr/bin/env bash
# requires binaries: lsoft, wc
# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  for port in $*; do
    if [ "$port" == "" ]; then continue; fi
    while [ "$(lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "$port is ready."
    echo "found according PIDs:"
    echo $(lsof -t -i:${port})
  done
}
