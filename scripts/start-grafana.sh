#!/bin/bash

source "/vagrant/scripts/common.sh"

function startServices {
  echo "starting grafana service"
  nohup /usr/local/grafana/bin/grafana-server \
    --config="/usr/local/grafana/conf/sample.ini" \
    --homepath="/usr/local/grafana" > /dev/null 2>&1 &
}

echo "start grafana"

startServices

echo "start grafana complete"
