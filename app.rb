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

not_found do
    redirect '/'
end

get %r{/([a-zA-Z0-9\-_]+)/?(.*)?} do |user, url|
  @user, @url = user, url  
  if File.directory? :blogs.to_s + '/' + @user
    $blog = Existed.new @user, @url
    slim :blog
  else
    redirect '/'
  end
end