# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.2"

Vagrant.configure(2) do |config|
  config.vm.define "application" do |application|

    application.vm.box = "ubuntu/trusty64"
    application.vm.box_check_update = false

    # App interface
    application.vm.network "private_network", ip: "10.255.255.101"

    unless ENV['VAGRANT_NFS']
      application.vm.synced_folder ".", "/vagrant"
    else
      application.vm.synced_folder '.', '/vagrant',
        :nfs => true,
        :linux__nfs_options => ['rw','no_subtree_check','all_squash','async','nolock']
    end

    application.vm.provider "virtualbox" do |vb|
      vb.customize [
        "modifyvm", :id,
        "--name", "Application",
        "--memory", 5120,
        "--cpus", 8,
        "--ioapic", "on",
        "--pae", "on",
        "--chipset", "piix3",
        '--natdnshostresolver1', 'on'
      ]
    end

    application.vm.provision "packages", type: "shell", preserve_order: true, path: "vagrant/provisions/packages.sh", binary: true;
    application.vm.provision "mysql", type: "shell", preserve_order: true, path: "vagrant/provisions/mysql.sh", binary: true;
    application.vm.provision "php", type: "shell", preserve_order: true, path: "vagrant/provisions/php.sh", binary: true;
    application.vm.provision "nginx", type: "shell", preserve_order: true, path: "vagrant/provisions/nginx.sh", binary: true;
    application.vm.provision "composer", type: "shell", preserve_order: true, path: "vagrant/provisions/composer.sh", binary: true;
    application.vm.provision "help", type: "shell", preserve_order: true, path: "vagrant/provisions/help.sh", binary: true;

  end

  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.ssh.insert_key = "true"
end
