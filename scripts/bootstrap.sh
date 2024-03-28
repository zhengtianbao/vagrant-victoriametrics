#!/bin/bash
# If you restart your VM then the VictoriaMetrics services will be started by this script.
# Due to the config "node.vm.provision :shell, path: "scripts/bootstrap.sh", run: 'always'" on Vagrantfile

bash /vagrant/scripts/start-node_exporter.sh # Start node_exporter.
bash /vagrant/scripts/start-prometheus.sh # Start prometheus.
bash /vagrant/scripts/start-alertmanager.sh # Start alertmanager.
bash /vagrant/scripts/start-victoriametrics.sh # Start VictoriaMetrics cluster.
bash /vagrant/scripts/start-grafana.sh # Start grafana.
