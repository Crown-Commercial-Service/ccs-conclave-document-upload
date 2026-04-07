source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
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
gem 'bootsnap', require: false

# File uploader
gem 'carrierwave', '>= 3.1.2'

# for S3 storage of files
gem 'carrierwave-aws', '>= 1.6.1'

# Helps you manage translations
gem 'i18n-tasks'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Make http requests
gem 'httparty'

# Manage secret keys on local
gem 'figaro'

# Exception tracking
gem 'rollbar'

# Environment variables management
gem 'vault'

# static code analyzer
gem 'rubocop', require: false
gem 'rubocop-rails', require: false

# Sidekiq - using an older version that works with redis v3.2.6 (Pre-June 2023)
# Upgraded Sidekiq from 6.4.2 to 6.5.6, as advised (June 2023). See: https://github.com/sidekiq/sidekiq/issues/5488
gem 'sidekiq', '~> 6.5.6'

# Updated from 3.0.1 to 3.2.2, to match Sidekiq version upgrade (June 2023). See: https://github.com/sidekiq/sidekiq/issues/5372
gem 'sidekiq-scheduler', '~> 3.2.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Rspec
  gem 'rspec-rails'
end

group :development do
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby ruby]

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'database_cleaner'
  gem 'webmock', '>= 3.25.1'
  gem 'rspec-sidekiq'
  gem 'simplecov', require: false
  gem 'climate_control'
end
