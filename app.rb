require 'sinatra'
require 'dragonfly'
require 'RMagick'
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
  "Create an image by just a string after the url."
end

get "/:slug" do |slug|
  background_colors = %w(#EEEEEE #F2F2F2 #F5B7AB #EE836E #FFE8AA #FEDE88 #C5E5DE #95D1C4 #B1E0EC #6DC5DC)

  ImageLogger.create(:slug => slug, :data => "#{Time.now.to_s}\n#{request.user_agent}\n#{request.ip}\n", :created_at => Time.now)
  logs = ImageLogger.all(:slug => slug)
  data = []
  logs.each {|l| data << l['data']}
  Dragonfly.app.generate(
    :text,
    "#{slug}\n\n#{data.join("\n")}",
    "font-size" => 14,
    "padding" => '10',
    "background-color" => background_colors[rand(background_colors.count)]
  ).to_response(env)
end

get "/:slug/log" do |slug|
  logs = ImageLogger.all(:slug => slug)
  data = []
  logs.each {|l| data << l['data'].gsub("\n", "<br/>")}
  "#{data.join("<br/>")}"
end

#remove all logs
delete "/:slug/destroy" do |slug|
  logs = ImageLogger.all(:slug => slug)
  logs.destroy
  redirect "/#{slug}/log"
end

#remove the last log
delete "/:slug/remove" do |slug|
  log = ImageLogger.last(:slug => slug)
  log.destroy
  redirect "/#{slug}/log"
end
