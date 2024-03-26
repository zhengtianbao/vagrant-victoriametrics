Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |v|
    v.memory = 8192
    v.cpus = 4
  end
  
  config.vm.define :monitor do |node|
    node.vm.box = "ubuntu/focal64"
    node.vm.hostname = "monitor"
    node.vm.network :private_network, ip: "192.168.56.10"
    node.vm.provision :shell, path: 'scripts/setup-ubuntu.sh'
    node.vm.provision :shell, path: 'scripts/setup-node_exporter.sh'
    node.vm.provision :shell, path: 'scripts/setup-prometheus.sh'
    node.vm.provision :shell, path: 'scripts/setup-victoriametrics.sh'
    node.vm.provision :shell, path: 'scripts/bootstrap.sh', run: 'always'
  end
end
