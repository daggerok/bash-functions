#!/usr/bin/env bash
# requires binaries: sudo, lsoft, wc
# helper sudo_wait_for function, usage: `sudo_wait_for 8080 8081`
function sudo_wait_for {
  for port in $*; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ "$(sudo lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "$port is ready."
    echo "found according PIDs:"
    echo $(sudo lsof -t -i:${port})
  done
}
############################################
#!/usr/bin/env bash
# requires binaries: lsoft, wc
# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  for port in "$*"; do
    if [ ".${port}" == "." ]; then continue; fi
    while [ "$(lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "${port} is ready."
    echo "found according PIDs:"
    echo $(lsof -t -i:${port})
  done
}
############################################
#!/usr/bin/env bash
# required: sudo, lsof, kill
# helper stop_any function. usage: `stop_any 80 8080 5432`
function stop_any {
  for sourcePort in $*; do
    if [ ".${sourcePort}" == "." ]; then continue; fi
    for pid in $(sudo lsof -t -i:${sourcePort}); do
      sudo kill ${pid} >/dev/null 2>$1 | true
      if [ $? -eq 0 ]; then
        echo "PID $pid stopped."
      else
        echo "nothing is running by PID $pid.";
      fi;
    done
  done
}
############################################
# com.github.daggerok:bash-functions:1.0.1 #
############################################
