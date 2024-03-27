#!/bin/bash

source "/vagrant/scripts/common.sh"

function startServices {
  echo "starting prometheus service"
  nohup /usr/local/prometheus/prometheus \
    --storage.tsdb.path=/usr/local/prometheus/data \
    --config.file="/usr/local/prometheus/prometheus.yml" > ${PROMETHEUS_LOG_DIR}/prometheus.log 2>&1 &
}

echo "start prometheus"

startServices

echo "start prometheus complete"
