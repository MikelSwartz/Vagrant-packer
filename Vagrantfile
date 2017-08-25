# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.box = "centos/7"
  config.vm.hostname = "mgt01.packer"
  config.vm.network "private_network", ip: "10.0.15.200"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "shell", path: "provision.sh"
end
