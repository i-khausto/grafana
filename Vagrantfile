# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|


  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.box = "ubuntu/bionic64"
    monitoring.vm.hostname = "monitoring.example.com"
#    monitoring.disksize.size = '30GB'
#    monitoring.vm.network "public_network",
#      use_dhcp_assigned_default_route: true
    monitoring.vm.network "private_network", ip: "172.42.42.150"
    monitoring.vm.provider "virtualbox" do |v|
      v.name = "monitoring"
      v.memory = 3072
      v.cpus = 2
    end
    monitoring.vm.provision "shell", path: "monitoring.sh"
  end
end
