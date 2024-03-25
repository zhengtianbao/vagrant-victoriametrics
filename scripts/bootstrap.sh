#!/bin/bash
# If you restart your VM then the VictoriaMetrics services will be started by this script.
# Due to the config "node.vm.provision :shell, path: "scripts/bootstrap.sh", run: 'always'" on Vagrantfile

/vagrant/scripts/start-node_exporter.sh # Start node_exporter.
