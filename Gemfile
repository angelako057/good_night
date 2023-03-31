source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bootsnap", require: false

group :development, :test do
  gem "pry"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem "factory_bot"
  gem "faker"
end

group :development do
  gem "spring"
end

