#!/usr/bin/env bash
# required: sudo, lsof, kill
# helper stop_any function. usage: `sudo_stop_any 80 8080 5432`
function sudo_stop_any() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi

  # Verify required binaries are present
  required_bins=(sudo lsof kill)
  for bin in "${required_bins[@]}"; do
    if ! command -v "$bin" >/dev/null 2>&1; then
      echo "Error: required binary '$bin' is not installed." >&2
      echo "Please install it using your package manager." >&2
      return 1 2>/dev/null || exit 1
    fi
  done

  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    pids=$(sudo lsof -t -i:${port})
    for pid in ${pids}; do
      sudo kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID process: $pid was stopped."
      else
        echo "Nothing is running by PID $pid.";
      fi;
    done
  done
}
