Vagrant.configure("2") do |config|

    config.vm.box = "urban-theory/am2"
    config.vm.box_url = "http://static.urban-theory.net/boxes/am2.json"
    config.vm.box_version = "0.2.0"
    
    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end

    config.vm.synced_folder "./", "/vagrant", type: "virtualbox"

    config.vm.define "s1" do |s1|
        s1.vm.hostname = "s1"
        s1.vm.network "private_network", ip: "192.168.56.30"
        s1.vm.provision "ansible_local" do |ansible|
            ansible.playbook = "/vagrant/ansible/playbook-vagrant-s1.yml"
        end
    end
    config.vm.define "s2" do |s2|
        s2.vm.hostname = "s2"
        s2.vm.network "private_network", ip: "192.168.56.31"
        s2.vm.provision "ansible_local" do |ansible|
            ansible.playbook = "/vagrant/ansible/playbook-vagrant-s2.yml"
        end
    end

end
