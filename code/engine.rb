require 'date'
require 'psych'
require 'town'

class Existed
  attr_reader :name, :author, :description, :url

  def initialize user, post = ''
    @data = Psych.load_file :blogs.to_s + '/' + user + '/info.yml'
    @timestamps = :blogs.to_s + '/' + user + '/timestamps.yml'
    @time = (Psych.load_file @timestamps if File.exists? @timestamps) || {}
    $theme = @data['theme'] || $theme
    set :views, "views/#{$theme}"
    @posts = :blogs.to_s + '/' + user + '/' + :posts.to_s
  end

  def data param
    return @data[param]
  end

  def title id
    # JS does this; for search engines only
    # For speed, it searches for the header right in Markdown
    post = Dir["#{@posts}/#{id}"].first
    File.read(post)[/^.+(?=\n===+)|(?<=#)[^#\n]+|^.+(?=\n---+)/]
  end

  def link id, symbol = ''
    basename = id[/[^\/]+(?=\..+$)/]
    "#{@url + symbol + basename}/"
  end

  def time id
    Time.at @time[id]
  end

  def show id, page = 1
    all = Dir.new("#{@posts}/#{id}")
    posts = []
    all.each do |filename|
      file = "#{@posts}/#{id}" + filename
      if File.file? file
        if @time[filename].nil?
          @time[filename] = Time.now.to_i 
          File.write @timestamps, Psych.dump(@time)
        end; 
        -@time[filename]
        posts << file
      end
    end
    raise "No posts found: #{id}" if posts.empty?
    those = page.pred * $per_page...page * $per_page
    posts[those]
  end

  def check id, page
    # Checks if the page exists
    # (good for pagination)
    edge = page * @per
    not Dir["#{@posts}/#{id}"][edge].nil?
  end

  def post path, id
    post = path.dress
    date = (time path).strftime('%d.%m')
    post.gsub!(/(?<=<h1>).+(?=<\/h1>)/) {|h| "<a href='#{link path}'>#{h}</a>"} if id == '*'
    post.gsub!(/<h1>.+<\/h1>/) {|h| "#{h} <div class='time'>#{date}</div>"}
  post; end
end
