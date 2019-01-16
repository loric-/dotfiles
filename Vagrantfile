# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  if Vagrant.has_plugin?('vagrant-disksize')
    config.disksize.size = '130GB'
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = "dev"
    vb.gui = true

    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ['modifyvm', :id, '--vram', '256']
    vb.customize ['modifyvm', :id, '--memory', '8192']
    vb.customize ['modifyvm', :id, '--cpus', '4']
    vb.customize ['modifyvm', :id, '--bioslogofadein', 'off']
    vb.customize ['modifyvm', :id, '--bioslogofadeout', 'off']
    vb.customize ['modifyvm', :id, '--bioslogodisplaytime', '1000']
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, '--audio', 'dsound', '--audiocontroller', 'hda']
  end

  # Enable SSH forwarding
  config.ssh.forward_agent = true

  # Mount a shared folder
  if File.directory?(File.expand_path("~/Synced"))
    config.vm.synced_folder "~/Synced", "/home/vagrant/Synced"
  end

  # Copy SSH info
  if File.directory?(File.expand_path("~/.ssh"))
    config.vm.provision "file", run: "always", source: "~/.ssh", destination: ".ssh"
    if File.exists?("~/.ssh/id_rsa")
      config.vm.provision "shell", run: "always", privileged: false, inline: <<-SHELL
        chmod og-rw .ssh/id_rsa

        for i in .ssh/*.key; do
            [ -f "$i" ] || break
            chmod og-rw $i
        done
      SHELL
    end    
  end

  # Set timezone
  config.vm.provision :shell, :inline => "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime", run: "always"

  # Provision with prefered apps and tools
  config.vm.provision :shell, privileged: false, :path => "terminal.sh"
  config.vm.provision :shell, privileged: false, :path => "graphical.sh"

  # Clone dotfiles and install ubuntu desktop with lightdm
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    # Set zsh as default shell
    sudo chsh -s /bin/zsh vagrant

    # Run dotfiles
    rm -rf $HOME/.config/dotfiles
    git clone https://github.com/loric-/dotfiles.git $HOME/.config/dotfiles
    cd $HOME/.config/dotfiles && python3 link.py

    # Install vim plugins
    vim -c 'PlugInstall' -c 'qa!' > /dev/null

    # Install desktop environment for Ubuntu
    sudo apt-get install -y ubuntu-desktop

    # Install sound via alsa kernel modules
    sudo apt-add-repository -y ppa:ubuntu-audio-dev/alsa-daily
    sudo apt-get update
    sudo apt-get install -y oem-audio-hda-daily-dkms
    sudo modprobe snd-hda-intel

    # Fix sound
    echo "# VirtualBox Workaround"         | sudo tee -a /etc/pulse/daemon.conf
    echo "default-sample-rate = 48000"     | sudo tee -a /etc/pulse/daemon.conf
    echo "alternate-sample-rate = 44100"   | sudo tee -a /etc/pulse/daemon.conf
    echo "default-fragments = 2"           | sudo tee -a /etc/pulse/daemon.conf
    echo "default-fragment-size-msec = 55" | sudo tee -a /etc/pulse/daemon.conf

    # Set autologin on i3
    echo "[SeatDefaults]"           | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
    echo "autologin-user=vagrant"   | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
    echo "autologin-user-timeout=0" | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
    echo "user-session=i3"          | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf

    sudo systemctl reboot
  SHELL

end
