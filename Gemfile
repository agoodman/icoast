source 'https://rubygems.org'

ruby '1.9.2'

gem 'rails', '3.2.13'

gem 'jquery-rails'
gem 'haml'
gem 'will_paginate'
gem 'newrelic_rpm'
gem 'devise'
gem 'faker'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'  
end

group :test do
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :production do
  gem 'pg'
  gem 'mysql2'
  gem 'thin'
end

