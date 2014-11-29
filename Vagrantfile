# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    ### Define options for all VMs ###
    # Using vagrant-cachier improves performance if you run repeated yum/apt updates
    if defined? VagrantPlugins::Cachier
      config.cache.auto_detect = true
    end
    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "768", "--cpus", "4", "--ioapic", "on"]
    end
    # hack to avoid ubuntu/debian-specific 'stdin: is not a tty' error on startup
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    config.vm.define :debian7 do |node|
      node.vm.box = 'puppetlabs/debian-7.6-64-puppet'
      node.vm.hostname = 'debian7.boxnet'
      node.vm.network :private_network, ip: "192.168.37.25"
    end
end
