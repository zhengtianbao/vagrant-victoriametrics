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

function installLocalGrafanaVictoriaMetricsDatasourcePlugin {
  echo "install grafana victoriametrics datasource plugin file"
  FILE=/vagrant/resources/${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_ARCHIVE}
  mkdir -p /var/lib/grafana/plugins/
  tar -zxf $FILE -C /var/lib/grafana/plugins
}

function installRemoteGrafanaVictoriaMetricsDatasourcePlugin {
  echo "install grafana victoriametrics datasource plugin remote file"
  echo ${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_ARCHIVE} -O -L ${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_DOWNLOAD}
  mkdir -p /var/lib/grafana/plugins/
  tar -zxf /vagrant/resources/${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_ARCHIVE} -C /var/lib/grafana/plugins
}

function installGrafanaVictoriaMetricsDatasourcePlugin {
  if resourceExists ${GRAFANA_VICTORIAMETRICS_DATASOURCE_PLUGIN_ARCHIVE}; then
    installLocalGrafanaVictoriaMetricsDatasourcePlugin
  else
    installRemoteGrafanaVictoriaMetricsDatasourcePlugin
  fi
}

function setupGrafana {
  mkdir ${GRAFANA_LOG_DIR}
  echo "copy grafana configuration files"
  cp -rf ${GRAFANA_RES_DIR}/* /usr/local/grafana/
  installGrafanaVictoriaMetricsDatasourcePlugin
}

installGrafana

setupGrafana

echo "grafana setup complete"
