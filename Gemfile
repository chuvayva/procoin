source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 5.0.6'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'webpacker'


#model
gem 'enumerize'

# controller
gem 'devise'
gem 'devise_invitable'

# view
gem 'jbuilder', '~> 2.5'
gem 'slim'
gem 'draper'

# other
gem 'sidekiq'
gem 'sendgrid-ruby'
gem 'rollbar'
gem 'ethereum.rb'
gem 'eth'


group :development, :test do
  gem 'rspec-rails'
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  gem "letter_opener"
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'vcr'
  gem 'webmock'
  gem 'rails-controller-testing'
end

group :production do
  gem 'puma-heroku'
  gem 'rails_12factor'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

