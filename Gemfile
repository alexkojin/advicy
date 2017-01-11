source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

gem 'pg'

gem 'puma', '~> 3.0'

gem 'jbuilder', '~> 2.5'
gem 'rack-cors'

gem 'kaminari'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'figaro'

gem 'carrierwave'
gem 'mini_magick'
gem 'fog'

# authentication
gem 'devise'
gem 'jwt'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

# error notification
gem 'airbrake', '~> 5.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard-rspec'
  gem 'rb-fsevent', require: false
  gem 'terminal-notifier-guard'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Deploy`
  gem 'mina', require: false
  gem 'mina-whenever', require: false
  gem 'mina-systemd', require: false

  gem 'letter_opener'

  gem 'annotate'
end

group :test do
  # gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
