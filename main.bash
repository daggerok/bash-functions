#!/usr/bin/env bash

# helper wait_for function, usage: `wait_for 8080 8081`
function wait_for {
  for port in $*; do
    if [ "$port" == "" ]; then continue; fi
    while [ "$(sudo lsof -t -i:${port} | wc -l)" == "0" ]; do sleep 1; done;
    echo "$port is ready."
    echo "found:"
    echo $(sudo lsof -t -i:${port})
  done
}

#!/usr/bin/env bash

# helper stop_any function. usage: `stop_any 80 8080 5432`
function stop_any {
  for sourcePort in $*; do
    if [ "$sourcePort" == "" ]; then continue; fi
    for port in $(sudo lsof -t -i:${sourcePort}); do
      sudo kill ${port} > /dev/null 2>$1 | true
      if [ $? -eq 0 ]; then
        echo "$port stopped."
      else
        echo "nothing is running on port $port.";
      fi;
    done
  done
}
