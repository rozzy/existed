# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require 'bundler/setup'
Bundler.require :default

Dir["./code/*.rb"].each {|file| require file}
set :styles, 'styles'
set :views, 'views'
set :public_folder, 'public'

set :show_exceptions, true#false
error { File.read 'views/error.html' }

require './app'
run Sinatra::Application
