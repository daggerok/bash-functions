#!/usr/bin/env bash
# required: lsof, kill
# helper non_sudo_stop_any function. usage: `non_sudo_stop_any 8001 8002 8003`
function non_sudo_stop_any {
  for sourcePort in $*; do
    if [ ".${sourcePort}" == "." ]; then continue; fi
    for pid in $(lsof -t -i:${sourcePort}); do
      kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID was ${pid} stopped."
      else
        echo "PID ${pid} was not stopped.";
      fi;
    done
  done
}
