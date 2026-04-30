#!/usr/bin/env bash
# requires binaries: lsof, wc
# helper non_sudo_wait_for function, usage: `non_sudo_wait_for 8080 8081`
function non_sudo_wait_for() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi

  # Verify required binaries are present
  required_bins=(lsof wc)
  for bin in "${required_bins[@]}"; do
    if ! command -v "$bin" >/dev/null 2>&1; then
      echo "Error: required binary '$bin' is not installed." >&2
      echo "Please install it using your package manager." >&2
      return 1 2>/dev/null || exit 1
    fi
  done

  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ "$(lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "Port ${port} is ready. According PIDs:"
    echo $(lsof -t -i:${port})
  done
}
