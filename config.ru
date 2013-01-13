# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require 'bundler/setup'
require 'digest/sha1'
Bundler.require :default

set :styles, 'styles'
set :views, 'views'
set :blogs, 'blogs'
set :posts, 'posts'
set :public_folder, 'public'
set :show_exceptions, true

Dir["./code/*.rb"].each {|file| require file}

require './app'
run Sinatra::Application