$logger = Log4r::Logger.new('vagrantfile')
def read_ip_address(machine)
  command = "LANG=en ifconfig enp0s8| grep 'inet' | cut -d: -f2 | awk '{ print $2 }'"
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
  config.vm.network "public_network", bridge: "en1: Wi-Fi (AirPort)"
  config.vm.box = "puppetlabs/centos-7.2-64-nocm"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = false
  
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    read_ip_address(vm)
  end

  config.vm.define "mom" do |mom|
    mom.hostmanager.aliases = %w(mom)  
    mom.vm.hostname = "mom.testsky.vm"
    mom.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end 

  config.vm.define "console" do |console|
    console.hostmanager.aliases = %w(console)  
    console.vm.hostname = "console.testsky.vm"
    console.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

  config.vm.define "db" do |db|
    db.hostmanager.aliases = %w(db)  
    db.vm.hostname = "db.testsky.vm"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

  config.vm.define "mono" do |mono|
    mono.hostmanager.aliases = %w(mono)
    mono.vm.hostname = "mono.testsky.vm"
    mono.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
  end

  config.vm.define "lb" do |lb|
    lb.hostmanager.aliases = %w(lb)  
    lb.vm.hostname = "lb.mono.testsky.vm"
    lb.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
  end

  config.vm.define "cm1" do |cm1|
    cm1.hostmanager.aliases = %w(cm1)  
    cm1.vm.hostname = "cm1.mono.testsky.vm"
    cm1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

  config.vm.define "cm2" do |cm2|
    cm2.hostmanager.aliases = %w(cm2)
    cm2.vm.hostname = "cm2.mono.testsky.vm"  
    cm2.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end

  config.vm.define "agent1" do |agent1|
    agent1.hostmanager.aliases = %w(agent1)
    agent1.vm.hostname = "agent1.testsky.vm"
    agent1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
  end

  config.vm.define "agent2" do |agent2|
    agent2.hostmanager.aliases = %w(agent2)
    agent2.vm.hostname = "agent2.testsky.vm"
    agent2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
  end
end
