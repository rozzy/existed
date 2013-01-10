# encoding: utf-8
Dir.chdir File.dirname(__FILE__)
require './settings'
require 'sinatra'
require 'slim'
require 'sass'
require 'mongoid'
require_relative 'existed'

# error { File.read $error }
set :public_folder, $public
set :port, $port
set :views, $views

Mongoid.load! 'mongoid.yml'
Existed.new 'Блог Никитина Никиты', 'Existed.', 'Никитин Никита'

get '/*.css' do
  css = params[:splat].first
  # If there is a compiled one,
  # take it. Otherwise, use SASS.
  style = "#{$styles}/#{css}.css"
  if File.exists? style
    return File.read style
  end
  sass css.to_sym, {views: $styles}
end

get '/' do
  slim :index
end

get '/*/?' do
  page = params[:splat].first
  slim page.to_sym
end