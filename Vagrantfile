# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-12"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 4
  end

  config.vm.define "master" do |node|
    node.vm.hostname = "master"
    node.vm.network "private_network", ip: "192.168.56.10"
    config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    config.vm.synced_folder "./scripts", "/home/vagrant/shared", disabled: false
    config.vm.synced_folder "./shared/master", "/home/vagrant/shared/manifests", disabled: false
  end

  config.vm.define "node1" do |node|
      node.vm.hostname = "node1"
      node.vm.network "private_network", ip: "192.168.56.11"
      config.vm.network "forwarded_port", guest: 80, host: 8081, auto_correct: true
      config.vm.synced_folder "./scripts", "/home/vagrant/shared"
  end

  config.vm.define "node2" do |node|
    node.vm.hostname = "node2"
    node.vm.network "private_network", ip: "192.168.56.12"
    config.vm.network "forwarded_port", guest: 80, host: 8083, auto_correct: true
    config.vm.synced_folder "./scripts", "/home/vagrant/shared"
  end

end
# will handle this manually for now, note the order
#   config.vm.provision "shell", name: "disable-swap", path: "scripts/disable-swap.sh", privileged: false
#   config.vm.provision "shell", name: "install-essential-tools", path: "scripts/install-essential-tools.sh", privileged: false
#   config.vm.provision "shell", name: "allow-bridge-nf-traffic", path: "scripts/allow-bridge-nf-traffic.sh", privileged: false
#   config.vm.provision "shell", name: "install-containerd", path: "scripts/install-containerd.sh", privileged: false
#   config.vm.provision "shell", name: "install-kubeadm", path: "scripts/install-kubeadm.sh", privileged: false
#   config.vm.provision "shell", name: "update-kubelet-config", path: "scripts/update-kubelet-config.sh", args: ["eth1"], privileged: false
# end
