# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'

ruby '2.3.1'

require 'csv'

gem "rails", "4.1.6"
gem 'dotenv-rails'

## Bundle edge rails:
# gem "rails", :git => "git://github.com/rails/rails.git"

gem 'pg'
gem 'postgres_ext'

#gem 'fastercsv'

gem 'therubyracer'
gem 'RubyInline'
gem 'haml'
gem 'haml-rails'
gem 'coffee-script'
gem 'barista'
gem 'dynamic_form'
gem 'kaminari'

gem 'test-unit'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'yui-compressor'
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
end

group :development do
  gem 'wirble'
  gem "rails3-generators"
  gem 'capistrano'
  gem "capistrano-unicorn"
  gem "letter_opener"

  gem 'rmre', git: 'https://github.com/bosko/rmre.git'
  gem 'hirb'
  gem "meta_request"
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rbtrace'
  gem "rack-bug"
  gem 'irbtools-more', '>= 1.7.2', :require => false
  gem 'terminal-notifier'
  gem 'rails-footnotes', '~> 4.0'

  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'rubocop', require: false

  gem 'annotate', ">=2.5.0"
  gem "seed_dump", "~> 0.5.3"

  gem 'spring'
  gem 'spring-commands-rspec'

end

## Bundle the gems you use:
# gem "bj"
# gem "hpricot", "0.6"
# gem "sqlite3-ruby", :require => "sqlite3"
# gem "aws-s3", :require => "aws/s3"

## Bundle gems used only in certain environments:
# gem "rspec", :group => :test
# group :test do
#   gem "webrat"
# end
