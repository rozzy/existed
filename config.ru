# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require 'bundler/setup'
Bundler.require :default

Dir["./code/*.rb"].each {|file| require file}
set :public_folder, 'public'
set :styles, 'styles'
set :posts, 'posts'

# Run, Foster, run!
set :port, 2222
require './app'

configure :production do
  set :show_exceptions, false
  run Sinatra::Application
end
