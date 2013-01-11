# encoding: utf-8
# Folders
Dir["./code/*.rb"].each {|file| require file}
$views = 'views'
$styles = 'css'
$public = 'public'

# Variables
$error = "#{$views}/error.html"
$port = 1488
$per_page = 10