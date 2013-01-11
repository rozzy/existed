require 'date'

class Fizzy
  attr_reader :name, :author, :description, :url

  def initialize name, author, description, per = 10, url = '/blog/', posts = 'posts', dump = 'timestamps.yml'
    @posts, @url, @per, @dump = posts, url, per, dump # Kinda obvious, huh?
    @name, @author, @description = name, author, description
    @time = (Psych.load_file @dump if File.exists? @dump) || {}
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
    all = Dir["#{@posts}/#{id}"]
    all.sort_by! do |file|
      if @time[file].nil?
        @time[file] = Time.now.to_i 
        File.write @dump, Psych.dump(@time)
      end; -@time[file]
    end
    raise "No posts found: #{id}" if all.empty?
    those = page.pred * @per...page * @per
  all[those]; end

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