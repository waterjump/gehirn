ruby '2.3.0'

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'haml-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'rubocop', '~> 0.40.0', require: false
gem 'bundler'
gem 'dotenv-rails', groups: [:development, :test]
gem 'mediawiki_api'
gem 'forvo_api_client', git: 'https://github.com/FoboCasteR/forvo-api-client.git'
gem 'google_custom_search_api', git: 'https://github.com/waterjump/google_custom_search_api.git'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.4'
  gem 'capybara'
  gem 'better_errors'
  gem 'ffaker'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'poltergeist'
  gem 'launchy'
end

group :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec', '3.0.0'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
end

group :production do
  gem 'rails_12factor'
  gem 'bson_ext'
end
