#!/bin/bash

source "/vagrant/scripts/common.sh"

echo "setup victoriametrics"

function installLocalVictoriaMetrics {
  echo "install victoriametrics from local file"
  mkdir /usr/local/victoriametrics
  FILE=/vagrant/resources/${VICTORIAMETRICS_ARCHIVE}
  tar -zxf $FILE -C /usr/local/victoriametrics
  FILE=/vagrant/resources/${VMUTILS_ARCHIVE}
  tar -zxf $FILE -C /usr/local/victoriametrics
}

function installRemoteVictoriaMetrics {
  echo "install victoriametrics from remote file"
  mkdir /usr/local/victoriametrics
  echo ${VICTORIAMETRICS_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${VICTORIAMETRICS_ARCHIVE} -O -L ${VICTORIAMETRICS_DOWNLOAD}
  tar -xzf /vagrant/resources/${VICTORIAMETRICS_ARCHIVE} -C /usr/local/victoriametrics
  echo ${VMUTILS_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${VMUTILS_ARCHIVE} -O -L ${VMUTILS_DOWNLOAD}
  tar -xzf /vagrant/resources/${VMUTILS_ARCHIVE} -C /usr/local/victoriametrics
}

function installVictoriaMetrics {
  if resourceExists ${VICTORIAMETRICS_ARCHIVE}; then
    installLocalVictoriaMetrics
  else
    installRemoteVictoriaMetrics
  fi
}

function setupVictoriaMetrics {
  mkdir ${VICTORIAMETRICS_LOG_DIR}
  echo "copy victoriametrics configuration files"
  cp -f ${VICTORIAMETRICS_RES_DIR}/* /usr/local/victoriametrics/
}

installVictoriaMetrics

setupVictoriaMetrics

echo "victoriametrics setup complete"
