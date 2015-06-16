source 'https://rubygems.org'

# Rails Dependencies
gem 'rails', '4.2.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem "responders", "~> 2.0"

# Robot Dependencies
gem 'bootstrap-sass'
gem 'delayed_job_active_record'
gem 'devise'
gem 'doorkeeper'
gem 'fastly-rails'
gem 'figaro'
gem 'puma'

# Environment Dependencies
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  #-----------
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'sqlite3'
  gem 'mina', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'shoulda'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
