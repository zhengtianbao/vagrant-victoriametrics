#!/bin/bash

source "/vagrant/scripts/common.sh"

LOGPATH=/usr/local/node_exporter/logs

function startServices {
  echo "starting node_exporter service"
  nohup /usr/local/node_exporter/node_exporter > ${LOGPATH}/node_exporter.log 2>&1 &
}

echo "start node_exporter"

startServices

echo "start node_exporter complete"
