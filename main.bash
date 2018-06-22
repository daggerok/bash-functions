#!/usr/bin/env bash
# requires binaries: sudo, lsoft, wc
# helper sudo_wait_for function, usage: `sudo_wait_for 8080 8081`
function sudo_wait_for {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  ports=$*
  for port in ${ports}; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ $(sudo lsof -t -i:${port} | wc -l) == "0" ]; do sleep 1; done
    echo "$port is ready."
    echo "found according PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
############################################
#!/usr/bin/env bash
# requires binaries: lsof, wc
# helper non_sudo_wait_for function, usage: `non_sudo_wait_for 8080 8081`
function non_sudo_wait_for {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  ports=$*
  for port in ${ports}; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ "$(lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "${port} is ready."
    echo "found according PIDs:"
    echo $(lsof -t -i:${port})
  done
}
############################################
#!/usr/bin/env bash
# requires binaries: sudo, lsof, wc
# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  ports=$*
  echo "waiting for ports: $ports"
  for port in ${ports}; do
    if [ ".${port}" == "." ]; then continue; fi
    echo "waiting for port: ${port}"
    while [ $(sudo lsof -t -i:${port} | wc -l) == "0" ]; do sleep 1; done;
    echo "${port} is ready."
    echo "found according PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
############################################
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
  echo "stopping ports: $ports"
  for port in ${ports}; do
    echo "killing port: $port"
    if [ ".${port}" == "." ]; then continue; fi
    pids=$(sudo lsof -t -i:${port})
    echo "found pids: $pids"
    for pid in ${pids}; do
      echo "kill pid: $pid"
      sudo kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID $pid stopped."
      else
        echo "nothing is running by PID $pid.";
      fi;
    done
  done
}
############################################
#!/usr/bin/env bash
# required: lsof, kill
# helper non_sudo_stop_any function. usage: `non_sudo_stop_any 8001 8002 8003`
function non_sudo_stop_any {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  ports=$*
  for port in ${ports}; do
    if [ ".${port}" == "." ]; then continue; fi
    for pid in $(lsof -t -i:${port}); do
      kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID was ${pid} stopped."
      else
        echo "PID ${pid} was not stopped.";
      fi;
    done
  done
}
############################################
#!/usr/bin/env bash
# required: sudo, lsof, kill
# helper stop_any function. usage: `sudo_stop_any 80 8080 5432`
function sudo_stop_any {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME[0]} requires at least one argument:"
    echo "\t${FUNCNAME[0]} <port_number1> [...<more_port_numbers>]"
    return 0;
  fi
  ports=$*
  for port in ${ports}; do
    if [ ".${port}" == "." ]; then continue; fi
    pids=$(sudo lsof -t -i:${port})
    for pid in ${pids}; do
      sudo kill ${pid} >/dev/null 2>&1 | true
      if [ $? -eq 0 ]; then
        echo "PID $pid stopped."
      else
        echo "nothing is running by PID $pid.";
      fi;
    done
  done
}
############################################
# com.github.daggerok:bash-functions:2.0.0 #
############################################
