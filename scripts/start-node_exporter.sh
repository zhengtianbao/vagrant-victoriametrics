#!/bin/bash

source "/vagrant/scripts/common.sh"

function startServices {
  echo "starting node_exporter service"
  nohup /usr/local/node_exporter/node_exporter > ${NODE_EXPORTER_LOG_DIR}/node_exporter.log 2>&1 &
}

echo "start node_exporter"

startServices

echo "start node_exporter complete"
