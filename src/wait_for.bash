#!/usr/bin/env bash

# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  for port in $*; do
    while [ "$(sudo lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "$port is ready."
  done
}
