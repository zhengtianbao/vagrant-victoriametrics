#!/bin/bash

source "/vagrant/scripts/common.sh"

PROMETHEUS_RELEASE=prometheus-${PROMETHEUS_VERSION}.linux-amd64
PROMETHEUS_ARCHIVE=${PROMETHEUS_RELEASE}.tar.gz
PROMETHEUS_DOWNLOAD=https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${PROMETHEUS_ARCHIVE}
PROMETHEUS_RES_DIR=/vagrant/resources/prometheus

echo "setup prometheus"

function installLocalPrometheus {
  echo "install prometheus from local file"
  FILE=/vagrant/resources/${PROMETHEUS_ARCHIVE}
  tar -zxf $FILE -C /usr/local
}

function installRemotePrometheus {
  echo "install prometheus from remote file"
  echo ${PROMETHEUS_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${PROMETHEUS_ARCHIVE} -O -L ${PROMETHEUS_DOWNLOAD}
  tar -xzf /vagrant/resources/${PROMETHEUS_ARCHIVE} -C /usr/local
}

function installPrometheus {
  if resourceExists ${PROMETHEUS_ARCHIVE}; then
    installLocalPrometheus
  else
    installRemotePrometheus
  fi
  ln -s /usr/local/${PROMETHEUS_RELEASE} /usr/local/prometheus
}

function setupPrometheus {
  chmod +x /usr/local/prometheus/prometheus
  mkdir /usr/local/prometheus/logs
  echo "copy prometheus configuration files"
  cp -f ${PROMETHEUS_RES_DIR}/* /usr/local/prometheus/
}

installPrometheus

setupPrometheus

echo "prometheus setup complete"
