Vagrant.configure("2") do |config|

    config.vm.box = "urban-theory/am2"
    config.vm.box_url = "http://static.urban-theory.net/boxes/am2.json"
    config.vm.box_version = "0.2.0"
    
    config.vm.synced_folder "./", "/vagrant", type: "virtualbox"

    $ecr_config = <<-SCRIPT
    sudo mkdir -p /etc/nomad
    sudo bash -c 'echo "AWS_ACCESS_KEY_ID=#{ENV['AWS_ACCESS_KEY_ID']}" > /etc/nomad/ecr.config'
    sudo bash -c 'echo "AWS_SECRET_ACCESS_KEY=#{ENV['AWS_SECRET_ACCESS_KEY']}" >> /etc/nomad/ecr.config'
    sudo bash -c 'echo "AWS_DEFAULT_REGION=#{ENV['AWS_DEFAULT_REGION']}" >> /etc/nomad/ecr.config'
    sudo bash -c 'echo "VAULT_TOKEN=#{ENV['VAULT_TOKEN']}" >> /etc/nomad/vault.config'
    sudo chmod 600 /etc/nomad/vault.config
    SCRIPT

    config.vm.define "s1" do |s1|
        s1.vm.hostname = "s1"
        s1.vm.network "private_network", ip: "192.168.56.30"
        s1.vm.provision "shell", inline: $ecr_config
        s1.vm.provision "ansible_local" do |ansible|
            ansible.playbook = "/vagrant/ansible/playbook-vagrant-s1.yml"
        end
    end
    config.vm.define "s2" do |s2|
        s2.vm.hostname = "s2"
        s2.vm.network "private_network", ip: "192.168.56.31"
        s2.vm.provision "shell", inline: $ecr_config
        s2.vm.provision "ansible_local" do |ansible|
            ansible.playbook = "/vagrant/ansible/playbook-vagrant-s2.yml"
        end
    end
    config.vm.define "s3" do |s3|
        s3.vm.hostname = "s3"
        s3.vm.network "private_network", ip: "192.168.56.32"
        s3.vm.provision "shell", inline: $ecr_config
        s3.vm.provision "ansible_local" do |ansible|
            ansible.playbook = "/vagrant/ansible/playbook-vagrant-s3.yml"
        end
    end
end
