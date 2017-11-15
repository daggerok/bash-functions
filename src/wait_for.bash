#!/usr/bin/env bash

# helper wait_for function, usage: `wait_for 8080`
function wait_for {
  export port=$1
  while [ "$(sudo lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
  echo "$port is ready."
}
