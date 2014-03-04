# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "base"

  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  # Share Mesos package
  config.vm.synced_folder "pkg/", "/tmp/pkg/"

  # M1
  config.vm.define "mesos1" do |mesos|
    mesos.vm.hostname = "mesos1"

    #mesos.vm.network "public_network"
    mesos.vm.network "private_network", ip: "192.168.50.10"
  end

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "4096"
    v.vmx["numvcpus"] = "2"
  end
end
