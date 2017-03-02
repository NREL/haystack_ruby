# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 8000, host: 8080
  config.vm.network "forwarded_port", 127017, host: 27017
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
    # install rbenv
    # cd
    # git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    # echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    # echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    # exec $SHELL
    #install ruby-build
    # git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    # echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    # exec $SHELL
    #install ruby 2.4.0
    # rbenv install 2.4.0
    # rbenv global 2.4.0
    # rbenv rehash
    #install bundler
    # gem install bundler


   SHELL

end
