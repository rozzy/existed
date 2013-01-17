# SASS/Compass & CSS
get '/*.css' do |css|
  style = "#{settings.views}/#{css}.css"
  return File.read(style) if File.exists?(style)
  sass :"#{css}", Compass.sass_engine_options
    .merge(output: :compressed) 
end

get '/' do
  slim :index
end
