#!/usr/bin/env bash

# helper stop_any function. usage: `stop_any 8080`
function stop_any {
  for port in $*; do
    sudo kill $(sudo lsof -t -i:${port}) > /dev/null 2>$1 | true
    if [ $? -eq 0 ]; then
      echo "$port stopped."
    else
      echo "Nothing is running on port $port.";
    fi;
  done
}
