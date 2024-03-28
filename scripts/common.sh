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

# alertmanager
ALERTMANAGER_RELEASE=alertmanager-${ALERTMANAGER_VERSION}.linux-amd64
ALERTMANAGER_ARCHIVE=${ALERTMANAGER_RELEASE}.tar.gz
ALERTMANAGER_DOWNLOAD=https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/${ALERTMANAGER_ARCHIVE}
ALERTMANAGER_RES_DIR=/vagrant/resources/alertmanager
ALERTMANAGER_LOG_DIR=/usr/local/alertmanager/logs

# grafana
GRAFANA_RELEASE=grafana-${GRAFANA_VERSION}
GRAFANA_ARCHIVE=${GRAFANA_RELEASE}.linux-amd64.tar.gz
GRAFANA_DOWNLOAD=https://dl.grafana.com/oss/release/${GRAFANA_ARCHIVE}
GRAFANA_RES_DIR=/vagrant/resources/grafana
GRAFANA_LOG_DIR=/usr/local/grafana/logs
GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_RELEASE=victoriametrics-datasource-v${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_VERSION}
GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_ARCHIVE=${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_RELEASE}.tar.gz
GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_DOWNLOAD=https://github.com/VictoriaMetrics/grafana-datasource/releases/download/v${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_VERSION}/${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_ARCHIVE}

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
