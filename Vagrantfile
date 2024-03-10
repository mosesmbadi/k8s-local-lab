Vagrant.configure("2") do |config|

    config.vm.define "master" do |master|
      master.vm.box = "ubuntu/bionic64"
      master.ssh.insert_key = false
      master.vm.hostname = "master"
      master.vm.network "public_network", ip: "192.168.56.1", hostname: true, bridge: [
          "wlp0s20f3",
          "lo",
      ]
      master.vm.provision "shell", path: "./scripts/master.sh"
      master.vm.synced_folder "shared/", "/shared"

    end
  
    config.vm.define "worker" do |worker|
      worker.vm.box = "ubuntu/bionic64"
      worker.ssh.insert_key = false
      worker.vm.hostname = "worker"
      worker.vm.network "public_network", ip: "192.168.56.3", bridge: [
          "wlp0s20f3",
          "lo",
      ]

    end
  
  end
  