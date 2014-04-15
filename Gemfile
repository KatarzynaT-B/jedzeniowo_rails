source 'https://rubygems.org'
require 'rbconfig'

ruby '2.0.0'
gem 'rails', '4.0.3'

gem 'sass-rails', '4.0.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'

gem 'bootstrap-sass', '~> 3.1.1'
gem 'bootstrap-will_paginate', '0.0.9'

gem 'uglifier', '2.1.1'

gem 'nested_form'
gem 'will_paginate', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'bcrypt-ruby', '3.1.2'
gem 'sprockets', '2.11.0'
gem 'rake', '10.2.1'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.14.1'
  gem 'guard-rspec', '2.5.0', require: false
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'rb-notifu', '0.0.4'
  gem 'simplecov', require: false
  gem 'wdm', '0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
  gem 'launchy'
  gem 'shoulda'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

group :development do
  gem 'bullet'
  gem 'better_errors'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
