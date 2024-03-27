#!/bin/bash

source "/vagrant/scripts/common.sh"

echo "setup alertmanager"

function installLocalAlertmanager {
  echo "install alertmanager from local file"
  FILE=/vagrant/resources/${ALERTMANAGER_ARCHIVE}
  tar -zxf $FILE -C /usr/local
}

function installRemoteAlertmanager {
  echo "install alertmanager from remote file"
  echo ${ALERTMANAGER_DOWNLOAD}
  curl -Ss --retry 10 -o /vagrant/resources/${ALERTMANAGER_ARCHIVE} -O -L ${ALERTMANAGER_DOWNLOAD}
  tar -xzf /vagrant/resources/${ALERTMANAGER_ARCHIVE} -C /usr/local
}

function installAlertmanager {
  if resourceExists ${ALERTMANAGER_ARCHIVE}; then
    installLocalAlertmanager
  else
    installRemoteAlertmanager
  fi
  ln -s /usr/local/${ALERTMANAGER_RELEASE} /usr/local/alertmanager
}

function setupAlertmanager {
  chmod +x /usr/local/alertmanager/alertmanager
  mkdir ${ALERTMANAGER_LOG_DIR}
  echo "copy alertmanager configuration files"
  cp -f ${ALERTMANAGER_RES_DIR}/* /usr/local/alertmanager/
}

installAlertmanager

setupAlertmanager

echo "alertmanager setup complete"
