# SASS/Compass & CSS
get '/*.css' do |css|
  style = "#{settings.styles}/#{css}.css"
  return File.read(style) if File.exists?(style)
  sass :"#{css}", Compass.sass_engine_options
    .merge(views: settings.styles, output: :compressed) 
end

get '/*/rss/?' do |u|
  if File.directory? :blogs.to_s + '/' + u
    builder :rss
  else
    redirect '/'
  end
end

get '/' do
  slim :index
end

not_found do
    redirect '/'
end
  # '/*/*?'
get %r{/([a-zA-Z0-9\-_]+)/?(.[a-zA-Z0-9\-_]+)?} do |user, post|
  @user, @post = user, post
  if File.directory? :blogs.to_s + '/' + @user
    $blog = Existed.new @user, @post
    slim :blog
  else
    redirect '/'
  end
end

get '/*/settings' do |user|
  p user
end