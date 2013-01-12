# SASS/Compass & CSS
get '/*.css' do |css|
  style = "#{settings.styles}/#{css}.css"
  return File.read(style) if File.exists?(style)
  sass :"#{css}", Compass.sass_engine_options
    .merge(views: settings.styles, output: :compressed)
end

get '/*/rss/?' do |u|
  @user = u
  builder :rss
end

get '/' do
  slim :index
end

get '/*/?' do |u|
  @user = u
  slim :blog
end