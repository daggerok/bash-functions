#!/usr/bin/env bash
# required: sudo, lsof, kill
# helper stop_any function. usage: `stop_any 80 8080 5432`
function stop_any {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  ports=$*
  for port in "${ports}"; do
    if [ ".${port}" == "." ]; then continue; fi
    for pid in $(sudo lsof -t -i:${port}); do
      sudo kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID $pid stopped."
      else
        echo "nothing is running by PID $pid.";
      fi;
    done
  done
}
