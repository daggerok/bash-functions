#!/usr/bin/env bash
# required: sudo, lsof, kill
# helper stop_any function. usage: `stop_any 80 8080 5432`
function stop_any {
  for sourcePort in $*; do
    if [ ".${sourcePort}" == "." ]; then continue; fi
    for pid in $(sudo lsof -t -i:${sourcePort}); do
      sudo kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID $pid stopped."
      else
        echo "nothing is running by PID $pid.";
      fi;
    done
  done
}
