$logger = Log4r::Logger.new('vagrantfile')
def read_ip_address(machine)
  command = "LANG=en ifconfig enp0s3| grep 'inet' | cut -d: -f2 | awk '{ print $2 }'"
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

  config.vm.define "mom" do |mom|
    mom.hostmanager.aliases = %w(puppet)  
    mom.vm.hostname = "mom.testsky.vm"
    mom.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
  end 

  config.vm.define "web" do |web|
    web.hostmanager.aliases = %w(web)
    web.vm.hostname = "web.testsky.vm"
    web.vm.box = "puppetlabs/centos-6.6-64-nocm"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end

  config.vm.define "agent2" do |agent2|
    agent2.hostmanager.aliases = %w(agent2)
    agent2.vm.hostname = "agent2.testsky.vm"
    agent2.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end
end
