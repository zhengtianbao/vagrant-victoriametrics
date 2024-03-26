#!/bin/bash

source "/vagrant/scripts/common.sh"

LOGPATH=/usr/local/prometheus/logs

function startServices {
  echo "starting prometheus service"
  nohup /usr/local/prometheus/prometheus --config.file="/usr/local/prometheus/prometheus.yml" > ${LOGPATH}/prometheus.log 2>&1 &
}

echo "start prometheus"

startServices

echo "start prometheus complete"
