#!/usr/bin/env bash

# helper stop_any function. usage: `stop_any 8080`
function stop_any {
  export port=$1
  sudo kill $(sudo lsof -t -i:${port} 2>&1) | true
}
