# Skunk Labs

## Production Installation

## Development With Vagrant

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. Install [Vagrant](http://docs.vagrantup.com/v2/installation/index.html)
1. `git clone  http://<your username>@stash.childrenshc.org/scm/sw/skunklabs2.git && cd skunklabs2`
1. (Optional) Change to the development branch: `git checkout -b develop origin/develop`
1. `vagrant up`
1. Once Vagrant is running you can view the site in development mode at http://localhost:8080.
1. If gems are changed or if there are new migrations you can just run `vagrant provision`.
1. To restart the Rails server, type `touch tmp/restart.txt`. Or you can `vagrant reload` to restart the dev box.
1. When you want to stop the development instance simply type `vagrant halt`.

>For more help with Vagrant, check out the [Vagrant docs](http://docs.vagrantup.com/v2/).

## Development With Local Install

This covers the setup for Mac or Linux machines. If you're running Windows it's recommended that you use the Vagrant method.

1. Install [RVM](https://rvm.io/)
1. Install Git
1. `git clone  http://<your username>@stash.childrenshc.org/scm/sw/skunklabs2.git && cd skunklabs2`
1. (Optional) Change to the development branch: `git checkout -b develop origin/develop`
1. `cp config/database.yml{.example,}` - this provides you with a local SQLite database for development and testing.
1. `bundle install`
1. `rake secret` and copy the unique ID that it outputs for the next step.
1. `cp config/secrets.yml{.example,} && vim config/secrets.yml` and replace `REPLACE_THIS_TEXT` with the ID generated in the previous step.
1. `rake db:setup`
1. `rails server`

The development site will be available at http://localhost:3000/.

>Note: Nokogiri doesn't work out of the box on Windows 64bit. See this [page](https://github.com/sparklemotion/nokogiri/pull/989#issuecomment-28792210) for more information.

### Testing

Code submissions should have [RSpec](https://relishapp.com/rspec) tests.

You will need to ensure that initially and after each database migration you run:

`rake db:test:prepare`

To run the tests once:

`rspec`

For prolonged development sessions you might want tests to automatically execute while developing:

`guard -p`

#### Spring

SkunkLabs also uses [Spring](https://github.com/rails/spring) to speed up execution. You can check the status of Spring by running `spring status`. If for some reason Spring is not running you can start it by executing any `rails` command, such as `rails g` which is harmless without parameters.

>SkunkLabs Guard configuration automatically uses Spring.

To run tests with Spring: `spring rspec`.