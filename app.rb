# SASS/Compass & CSS
get '/*.css' do |css|
  style = "#{settings.styles}/#{css}.css"
  return File.read(style) if File.exists?(style)
  sass :"#{css}", Compass.sass_engine_options
    .merge(views: settings.styles, output: :compressed)
end

get '/' do
  slim :index
end

# Slim & HTML
get '/*/?' do |page|
  html = "#{settings.views}/#{page}.html"
  return File.read(html) if File.exists?(html)
  slim :"#{page}"
end
