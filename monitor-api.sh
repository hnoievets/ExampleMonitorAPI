#!/bin/bash

start() {
  cd /opt/monitor_api
  ./counter > /dev/null 2> /dev/null &
}

stop() {
  kill -s SIGKILL `ps -ef | grep -i "./counter" | awk '{print $2;}'`
}

case $1 in
  start|stop) "$1" ;;
esac
echo ""
