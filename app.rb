require 'sinatra'
require 'dragonfly'
require 'rmagick'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/app.db")
app = Dragonfly.app

Dragonfly.app.configure do
  plugin :imagemagick
end

class ImageLogger
  include DataMapper::Resource
  property :id, Serial
  property :slug, String
  property :data, Text
  property :created_at, DateTime
end

DataMapper.auto_upgrade!

get '/' do
  "Hello!"
end

get "/:slug" do |slug|
  ImageLogger.create(:slug => slug, :data => "#{Time.now.to_s}\n#{request.user_agent}\n#{request.ip}\n", :created_at => Time.now)
  logs = ImageLogger.all(:slug => slug)
  data = []
  logs.each {|l| data << l['data']}
  Dragonfly.app.generate(:text, data.join("\n"), "font-size" => 16).to_response(env)
end
