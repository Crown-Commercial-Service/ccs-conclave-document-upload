source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7', '>= 6.1.7.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.6', '>= 5.6.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# aws ssm
gem 'aws-sdk-ssm'

# aws dynamodb
gem 'aws-sdk-dynamodb'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# File uploader
gem 'carrierwave', '~> 2.2.2', '>= 2.2.2'

# for S3 storage of files
gem 'carrierwave-aws', '~> 1.5.0'

# Helps you manage translations
gem 'i18n-tasks', '~> 1.0.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Make http requests
gem 'httparty', '~> 0.21.0'

# Manage secret keys on local
gem 'figaro', '~> 1.2.0'

# Exception tracking
gem 'rollbar', '~> 3.1.1'

# Environment variables management
gem 'vault', '~> 0.15.0'

# static code analyzer
gem 'rubocop', '>= 1.7.0', require: false
gem 'rubocop-rails', '>= 2.21.1', require: false

# Sidekiq - using an older version that works with redis v3.2.6 (Pre-June 2023)
# Upgraded Sidekiq from 6.4.2 to 6.5.6, as advised (June 2023). See: https://github.com/sidekiq/sidekiq/issues/5488
gem 'sidekiq', '~> 6.5.6'

# Updated from 3.0.1 to 3.2.2, to match Sidekiq version upgrade (June 2023). See: https://github.com/sidekiq/sidekiq/issues/5372
gem 'sidekiq-scheduler', '~> 3.2.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Rspec
  gem 'rspec-rails', '~> 4.1.0'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby ruby]

group :test do
  gem 'factory_bot_rails', '~> 6.3.0'
  gem 'shoulda-matchers', '~> 4.5.0'
  gem 'faker'
  gem 'database_cleaner'
  gem 'webmock', '>= 3.10.0'
  gem 'rspec-sidekiq', '>= 4.0.0'
  gem 'simplecov', '0.20', require: false
  gem 'climate_control'
end
