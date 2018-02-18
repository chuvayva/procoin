source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 5.0.6'

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
#gem 'puma_worker_killer'
gem 'jbuilder', '~> 2.5'
gem 'rollbar'

gem 'webpacker'

#gem 'ethereum.rb'
#gem 'eth'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'puma-heroku'
  gem 'rails_12factor'
end
