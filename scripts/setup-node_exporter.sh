#!/bin/bash

source "/vagrant/scripts/common.sh"

echo "setup node_exporter"

function installLocalNodeExporter {
  echo "install node_exporter from local file"
  FILE=/vagrant/resources/${NODE_EXPORTER_ARCHIVE}
  tar -zxf $FILE -C /usr/local
}

function installRemoteNodeExporter {
  echo "install node_exporter from remote file"
  echo ${NODE_EXPORTER_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${NODE_EXPORTER_ARCHIVE} -O -L ${NODE_EXPORTER_DOWNLOAD}
  tar -xzf /vagrant/resources/${NODE_EXPORTER_ARCHIVE} -C /usr/local
}

function installNodeExporter {
  if resourceExists ${NODE_EXPORTER_ARCHIVE}; then
    installLocalNodeExporter
  else
    installRemoteNodeExporter
  fi
  ln -s /usr/local/${NODE_EXPORTER_RELEASE} /usr/local/node_exporter
}

function setupNodeExporter {
  chmod +x /usr/local/node_exporter/node_exporter
  mkdir ${NODE_EXPORTER_LOG_DIR}
}

installNodeExporter

setupNodeExporter

echo "node_exporter setup complete"
