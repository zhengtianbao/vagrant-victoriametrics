#!/bin/bash

source "/vagrant/scripts/common.sh"

function startWebhookReceiverService {
  echo "starting webhook receiver service"
  nohup python3 /usr/local/alertmanager/echo.py > ${ALERTMANAGER_LOG_DIR}/webhook.log 2>&1 &
}

function startAlertmanagerServices {
  echo "starting alertmanager service"
  nohup /usr/local/alertmanager/alertmanager \
    --config.file="/usr/local/alertmanager/alertmanager.yml" \
    --cluster.advertise-address="192.168.56.10:8001" \
    --cluster.listen-address="192.168.56.10:8001" \
    --cluster.peer="192.168.56.10:8002" \
    --cluster.peer-timeout=5s \
    --web.listen-address="0.0.0.0:9093" > ${ALERTMANAGER_LOG_DIR}/alertmanager0.log 2>&1 &
  nohup /usr/local/alertmanager/alertmanager \
    --config.file="/usr/local/alertmanager/alertmanager.yml" \
    --cluster.advertise-address="192.168.56.10:8002" \
    --cluster.listen-address="192.168.56.10:8002" \
    --cluster.peer="192.168.56.10:8001" \
    --cluster.peer-timeout=5s \
    --web.listen-address="0.0.0.0:9094" > ${ALERTMANAGER_LOG_DIR}/alertmanager1.log 2>&1 &
}

echo "start alertmanager"

startWebhookReceiverService
startAlertmanagerServices

echo "start alertmanager complete"
