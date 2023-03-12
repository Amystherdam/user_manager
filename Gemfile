source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4", ">= 7.0.4.2"

gem "propshaft"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem 'devise'
gem "pundit", "~> 2.3"

gem "actioncable", "~> 7.0"
gem "redis", "~> 5.0"
gem 'sidekiq'

gem "rubyXL", "~> 3.4"

gem 'faker', '~> 3.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'database_cleaner-active_record', '~> 2.0'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 6.0'
  gem 'shoulda-matchers', '~> 5.3'
end

group :development do
  gem "web-console"
end

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false
