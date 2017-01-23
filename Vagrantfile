$logger = Log4r::Logger.new('vagrantfile')
def read_ip_address(machine)
  command = "LANG=en ifconfig enp0s9| grep 'inet' | cut -d: -f2 | awk '{ print $2 }'"
  result  = ""

  $logger.info "Processing #{ machine.name } ... "

  begin
    # sudo is needed for ifconfig
    machine.communicate.sudo(command) do |type, data|
      result << data if type == :stdout
    end
    $logger.info "Processing #{ machine.name } ... success"
  rescue
    result = "# NOT-UP"
    $logger.info "Processing #{ machine.name } ... not running"
  end

  # the second inet is more accurate
  result.chomp.split("\n").last
end

Vagrant.configure(2) do |config|
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
  config.vm.network "private_network", type: "dhcp"
  config.vm.box = "puppetlabs/centos-7.2-64-nocm"
  config.ssh.insert_key = false

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = false
  
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    read_ip_address(vm)
  end

  config.vm.define "master" do |master|
    master.hostmanager.aliases = %w(puppet)
    master.vm.hostname = "master.testsky.vm"
    master.vm.box = "foreman-master"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
  end

  config.vm.define "web" do |web|
    web.hostmanager.aliases = %w(web)
    web.vm.hostname = "web.testsky.vm"
    web.vm.box = "puppetlabs/centos-6.6-64-nocm"
    web.vm.provision "shell", path: "install_agent.sh"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "db" do |db|
    db.hostmanager.aliases = %w(db)
    db.vm.hostname = "db.testsky.vm"
    db.vm.provision "shell", path: "install_agent.sh"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "api" do |api|
    api.hostmanager.aliases = %w(api)
    api.vm.hostname = "api.testsky.vm"
    api.vm.box = "puppetlabs/centos-6.6-64-nocm"
    api.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "voice" do |voice|
    voice.hostmanager.aliases = %w(voice)
    voice.vm.hostname = "voice.testsky.vm"
    voice.vm.box = "puppetlabs/centos-6.6-64-nocm"
    voice.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "admin" do |admin|
    admin.hostmanager.aliases = %w(admin)
    admin.vm.hostname = "admin.testsky.vm"
    admin.vm.box = "puppetlabs/centos-6.6-64-nocm"
    admin.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "chat" do |chat|
    chat.hostmanager.aliases = %w(chat)
    chat.vm.hostname = "chat.testsky.vm"
    chat.vm.box = "puppetlabs/centos-6.6-64-nocm"
    chat.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "zabbix" do |zabbix|
    zabbix.hostmanager.aliases = %w(zabbix)
    zabbix.vm.hostname = "zabbix.testsky.vm"
    zabbix.vm.provision "shell", path: "install_agent.sh"
    zabbix.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
  end

  config.vm.define "base" do |base|
    base.hostmanager.aliases = %w(base)
    base.vm.hostname = "base.testsky.vm"
    base.vm.provision "shell", path: "install_agent.sh"
    base.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
  end

   config.vm.define "base6" do |base6|
    base6.hostmanager.aliases = %w(base6)
    base6.vm.hostname = "base6.testsky.vm"
    base6.vm.box = "puppetlabs/centos-6.6-64-nocm"
    base6.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

   config.vm.define "sbc" do |sbc|
    sbc.hostmanager.aliases = %w(sbc)
    sbc.vm.hostname = "sbc.testsky.vm"
    sbc.vm.box = "puppetlabs/centos-6.6-64-nocm"
    sbc.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "connie" do |connie|
    connie.hostmanager.aliases = %w(connie)
    connie.vm.hostname = "connie.testsky.vm"
    connie.vm.provision "shell", path: "install_agent.sh"
    connie.vm.provider "virtualbox" do |vb|
      vb.memory = "6144"
    end
  end

  config.vm.define "rundeck" do |rundeck|
    rundeck.hostmanager.aliases = %w(rundeck)
    rundeck.vm.hostname = "rundeck.testsky.vm"
    rundeck.vm.provision "shell", path: "install_agent.sh"
    rundeck.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end
end
