source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'bootsnap', require: false
gem 'bootstrap'
gem 'bootstrap5-kaminari-views'
gem 'brazil-cep'
gem 'devise'
gem 'dotenv-rails'
gem 'importmap-rails'
gem 'jbuilder'
gem 'kaminari'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'ransack'
gem 'redis', '~> 4.0'
gem 'sass-rails'
gem 'sidekiq'
gem 'simple_form'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Debug
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-nav'
  gem 'pry-rails'

  # Security
  gem 'brakeman'

  # Quality
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  # RSpec
  gem 'rspec-rails'

  # Utility
  gem 'faker'
end

group :development do
  gem 'solargraph', require: false
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
