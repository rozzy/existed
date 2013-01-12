# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require 'bundler/setup'
Bundler.require :default

#set :database, ENV['DATABASE_URL'] || 'postgres://localhost/existed'
conn = PG.connect( dbname: 'existed' )
conn.exec( "SELECT url, title, username FROM users" ) do |result|
  puts "     url | title             | username"
  result.each do |row|
    puts row['url'] + ', ' + row['title'] + ', ' + row['username']
  end
end
#Mongoid.load!('./mongo.yml', :development)
Dir["./code/*.rb"].each {|file| require file}
set :styles, 'styles'
set :views, 'views'
set :public_folder, 'public'
set :show_exceptions, true

require './app'
run Sinatra::Application