# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require 'bundler/setup'
Bundler.require :default

Mongoid.load!('./mongo.yml')
Dir["./code/*.rb"].each {|file| require file}
set :styles, 'styles'
set :views, 'views'
set :public_folder, 'public'
set :show_exceptions, true

require './app'
run Sinatra::Application
