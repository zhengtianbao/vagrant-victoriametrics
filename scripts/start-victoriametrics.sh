#!/bin/bash

source "/vagrant/scripts/common.sh"

function startVMStorageServices {
  echo "starting vmstorage services"
  for ((i=0; i<3; i++)); do
    nohup /usr/local/victoriametrics/vmstorage-prod \
      --retentionPeriod=30d \
      --storageDataPath=/usr/local/victoriametrics/data${i} \
      --dedup.minScrapeInterval=15s \
      --vminsertAddr=:$((8400+i*100)) \
      --vmselectAddr=:$((8401+i*100)) \
      --httpListenAddr=:$((8482+i*100)) > ${VICTORIAMETRICS_LOG_DIR}/vmstorage${i}.log 2>&1 &
  done
}

function startVMInsertServices {
  echo "starting vminsert services"
  for ((i=0; i<3; i++)); do
    nohup /usr/local/victoriametrics/vminsert-prod \
      --replicationFactor=2 \
      --maxLabelsPerTimeseries=50 \
      --storageNode=127.0.0.1:8400,127.0.0.1:8500,127.0.0.1:8600 \
      --httpListenAddr=:$((8480+i*100)) > ${VICTORIAMETRICS_LOG_DIR}/vminsert${i}.log 2>&1 &
  done
}

function startVMSelectServices {
  echo "starting vmselect services"
  for ((i=0; i<3; i++)); do
    nohup /usr/local/victoriametrics/vmselect-prod \
      --dedup.minScrapeInterval=15s \
      --search.maxSamplesPerQuery=10000000000 \
      --search.maxSeries=100000 \
      --search.maxQueryLen=163840 \
      --storageNode=127.0.0.1:8401,127.0.0.1:8501,127.0.0.1:8601 \
      --httpListenAddr=:$((8481+i*100)) > ${VICTORIAMETRICS_LOG_DIR}/vmselect${i}.log 2>&1 &
  done
}

function startVMAuthService {
  echo "starting vmauth service"
  nohup /usr/local/victoriametrics/vmauth-prod \
    --auth.config=/usr/local/victoriametrics/vmauth.yml \
    --maxConcurrentRequests=10000 \
    --maxConcurrentPerUserRequests=5000 \
    --httpListenAddr=:8427 > ${VICTORIAMETRICS_LOG_DIR}/vmauth.log 2>&1 &
}

function startVMAlertService {
  echo "starting vmalert service"
  for ((i=0; i<2; i++)); do
    nohup /usr/local/victoriametrics/vmalert-prod \
      --rule=/usr/local/victoriametrics/rules.yml \
      --datasource.url=http://127.0.0.1:8427 \
      --datasource.bearerToken=selectuser \
      --notifier.url=http://127.0.0.1:9093 \
      --notifier.url=http://127.0.0.1:9094 \
      --configCheckInterval=1m \
      --evaluationInterval=15s \
      --httpListenAddr=:$((8880+i)) > ${VICTORIAMETRICS_LOG_DIR}/vmalert${i}.log 2>&1 &
  done
}

echo "start victoriametrics cluster"

startVMStorageServices
startVMInsertServices
startVMSelectServices
startVMAuthService
startVMAlertService

echo "start victoriametrics cluster complete"
