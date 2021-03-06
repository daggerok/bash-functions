#!/usr/bin/env bash
# required: lsof, kill
# helper non_sudo_stop_any function. usage: `non_sudo_stop_any 8001 8002 8003`
function non_sudo_stop_any {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    for pid in $(lsof -t -i:${port}); do
      kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID process: ${pid} was stopped."
      else
        echo "Nothing is running by PID ${pid}.";
      fi;
    done
  done
}
