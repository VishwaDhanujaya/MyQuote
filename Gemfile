source "https://rubygems.org"

ruby ">= 3.0.2", "< 3.4"

gem "rails", "~> 7.0.4"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"
# Use the Puma web server
gem "puma", "~> 5.0"
# Use JavaScript with ESM import maps
gem "importmap-rails"
# Hotwire's SPA-like page accelerator
gem "turbo-rails"
# Hotwire's modest JavaScript framework
gem "stimulus-rails"
# Build JSON APIs with ease
gem "jbuilder"

# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ], require: "debug/prelude"
end

group :development do
  gem "web-console"
  gem "listen", "~> 3.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
