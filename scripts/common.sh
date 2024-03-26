#!/bin/bash

source "/vagrant/scripts/versions.sh"

# node_exporter
NODE_EXPORTER_RELEASE=node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64
NODE_EXPORTER_ARCHIVE=${NODE_EXPORTER_RELEASE}.tar.gz
NODE_EXPORTER_DOWNLOAD=https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/${NODE_EXPORTER_ARCHIVE}
NODE_EXPORTER_LOG_DIR=/usr/local/node_exporter/logs

# prometheus
PROMETHEUS_RELEASE=prometheus-${PROMETHEUS_VERSION}.linux-amd64
PROMETHEUS_ARCHIVE=${PROMETHEUS_RELEASE}.tar.gz
PROMETHEUS_DOWNLOAD=https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${PROMETHEUS_ARCHIVE}
PROMETHEUS_RES_DIR=/vagrant/resources/prometheus
PROMETHEUS_LOG_DIR=/usr/local/prometheus/logs

# victoriametrics
VICTORIAMETRICS_RELEASE=victoria-metrics-linux-amd64-v${VICTORIAMETRICS_VERSION}-cluster
VICTORIAMETRICS_ARCHIVE=${VICTORIAMETRICS_RELEASE}.tar.gz
VICTORIAMETRICS_DOWNLOAD=https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v${VICTORIAMETRICS_VERSION}/${VICTORIAMETRICS_ARCHIVE}
VMUTILS_RELEASE=vmutils-linux-amd64-v${VICTORIAMETRICS_VERSION}
VMUTILS_ARCHIVE=${VMUTILS_RELEASE}.tar.gz
VMUTILS_DOWNLOAD=https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v${VICTORIAMETRICS_VERSION}/${VMUTILS_ARCHIVE}
VICTORIAMETRICS_RES_DIR=/vagrant/resources/victoriametrics
VICTORIAMETRICS_LOG_DIR=/usr/local/victoriametrics/logs

# utility functions
function resourceExists {
  FILE=/vagrant/resources/$1
  if [ -e $FILE ]
  then
    return 0
  else
    return 1
  fi
}

function fileExists {
  FILE=$1
  if [ -e $FILE ]
  then
    return 0
  else
    return 1
  fi
}
