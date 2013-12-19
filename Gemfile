source 'https://rubygems.org'
gem 'sinatra'
gem 'dragonfly'
gem 'rmagick', :require => 'RMagick'
gem 'data_mapper'

group :production do
  gem 'pg'
  gem 'dm-postgres-adapter'
end

group :development, :test do
  gem 'sqlite3'
  gem 'dm-sqlite-adapter'
end
