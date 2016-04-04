VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'fnando/hellobits-trusty64'
  config.ssh.insert_key = false
  #config.vm.network :private_network, ip: "10.0.0.50"
  #config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.network :forwarded_port, host: 15432, guest: 5432
  config.vm.network :forwarded_port, guest: 3003, host: 3003    # rails
  config.vm.network :forwarded_port, guest: 9292, host: 9292    # rack
  config.vm.network :forwarded_port, guest: 4567, host: 4567    # sinatra
  config.vm.network :forwarded_port, guest: 1080, host: 1080    # mailcatcher
  config.vm.network :forwarded_port, guest: 8888, host: 8888    # jasmine
  config.vm.network :forwarded_port, guest: 3306, host: 3306    # mysql
  config.vm.network :forwarded_port, guest: 1234, host: 1234    # node
  config.vm.network :forwarded_port, guest: 6379, host: 6379    # redis
  config.vm.network :forwarded_port, guest: 9200, host: 9200    # elasticsearch
  config.vm.network :forwarded_port, guest: 27017, host: 27017  # mongodb
  config.vm.network :forwarded_port, guest: 80, host: 8080      # apache/nginx
end