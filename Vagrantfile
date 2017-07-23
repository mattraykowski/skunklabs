# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Get the version of Ruby we'll be using.
$ruby_version = File.read(File.expand_path("../.ruby-version", __FILE__)).strip
$ruby_gemset = File.read(File.expand_path("../.ruby-gemset", __FILE__)).strip

# The root level setup script.
$script = <<SCRIPT
cd ~/
set -ex

# The script to run as the vagrant user.
user=$(cat <<USER
  set -ex

  # install rvm
  if [[ ! -d \\$HOME/.rvm ]]; then
    curl -sSL --insecure https://get.rvm.io | bash -s stable
    \\$HOME/.rvm/bin/rvm requirements
  fi
  source \\$HOME/.rvm/scripts/rvm
  rvm use --install #{$ruby_version}

  # bundle gems
  cd /vagrant
  gem install bundler --no-ri --no-rdoc
  if [[ ! -e config/database.yml ]]; then
    cp config/database.yml{.example,}
  fi
  bundle install

  if [[ ! -e config/secrets.yml ]]; then
    secret=\\$(/home/vagrant/.rvm/gems/#{$ruby_version}@#{$ruby_gemset}/bin/rake -s secret)
    sed -e"s/REPLACE_THIS_TEXT/\\$secret/g" config/secrets.yml.example > config/secrets.yml
  fi
  \\$HOME/.rvm/gems/#{$ruby_version}@#{$ruby_gemset}/bin/rake db:setup

USER
)


SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.network "forwarded_port", guest: 3000, host: 8080, auto_correct: true
  config.ssh.forward_agent = true

  # Apply the provisioning script.
  config.vm.provision :shell, inline: $setup
end
