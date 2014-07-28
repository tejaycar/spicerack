# -*- mode: ruby -*-
# vi: set ft=ruby :

box = 'precise64'
box_url = "http://files.vagrantup.com/#{ box }.box"

net_base = '192.168.33'


Vagrant.configure('2') do |config|

  config.ssh.private_key_path = '~/.ssh/vagrant'

  config.omnibus.chef_version = :latest

  config.vm.box = box
  config.vm.box_url = box_url

  config.vm.network :private_network, ip: "#{net_base}.30"
  config.vm.hostname = 'spicerack-vagrant'

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize [
      'modifyvm', :id,
      '--cpus', '1',
      '--memory', '2048',
      '--cpuexecutioncap', '75'
    ]
  end

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug

    chef.cookbooks_path = 'cookbooks'
    chef.run_list = [
      'recipe[chef_handler::json_file]',
      'recipe[spicerack::debug_all]'
    ]
  end
end
