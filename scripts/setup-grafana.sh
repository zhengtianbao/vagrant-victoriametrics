#!/bin/bash

source "/vagrant/scripts/common.sh"

echo "setup grafana"

function installLocalGrafana {
  echo "install grafana from local file"
  FILE=/vagrant/resources/${GRAFANA_ARCHIVE}
  tar -zxf $FILE -C /usr/local
}

function installRemoteGrafana {
  echo "install grafana from remote file"
  echo ${GRAFANA_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${GRAFANA_ARCHIVE} -O -L ${GRAFANA_DOWNLOAD}
  tar -xzf /vagrant/resources/${GRAFANA_ARCHIVE} -C /usr/local
}

function installGrafana {
  if resourceExists ${GRAFANA_ARCHIVE}; then
    installLocalGrafana
  else
    installRemoteGrafana
  fi
  ln -s /usr/local/${GRAFANA_RELEASE} /usr/local/grafana
}

function setupGrafana {
  mkdir ${GRAFANA_LOG_DIR}
}

installGrafana

setupGrafana

echo "grafana setup complete"
