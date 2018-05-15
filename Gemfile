source 'https://rubygems.org'

require 'rbconfig'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.7'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2.0'

# Use Bower for JS assets
gem 'bower-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'mysql2'
end

group :development, :test do
  if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
    gem 'nokogiri', '1.6.1.beta.1.mingw.1'
    gem 'wdm', '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
  else
    gem 'nokogiri'
  end

  gem 'spring'

  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_bot_rails'
  gem 'spring-commands-rspec'
  gem 'childprocess'
  gem 'syntax'
  gem 'pry'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'rails-controller-testing'

  # Notifiers
  gem 'rb-notifu'
  if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
    gem 'win32console'
  end

 end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'rails_best_practices'
end

gem 'devise'
gem 'devise_ldap_authenticatable'
gem 'gravatar_image_tag'
gem 'kaminari'
