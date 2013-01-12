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
  @url = u
  $db.exec( "SELECT title, description, username, password FROM users WHERE url = '#{u}' LIMIT 1" ) do |result|
    if result.count > 0
        $blog = result[0]
        $blog['password'] = Digest::SHA1.hexdigest $blog['password']
        slim :blog
    else
        redirect '/'
    end
  end
end