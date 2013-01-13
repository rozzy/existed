# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require 'bundler/setup'
require 'digest/sha1'
Bundler.require :default

Dir["./code/*.rb"].each {|file| require file}
set :styles, 'styles'
set :views, 'views'
set :public_folder, 'public'
set :show_exceptions, true

require './app'
run Sinatra::Application