def add_url(url_string, url_tags)
  puts "add_url bookmark_hash: #{@bookmark_hash['bookmarks'].inspect}" if @debug
  @bookmark_hash['bookmarks'] << {"url": url_string, "tags": url_tags.to_a}
  @bookmark_hash['bookmarks'].uniq!
  dump_hash if @debug
  true
end


def search_hash(target)
  index_retained_hash = {}
  @bookmark_hash['bookmarks'].each_with_index do |e, i|
    if e["url"].include? target or e["tags"].include? target
      index_retained_hash[i] = e["url"]
    end
  end
  puts_indexed_bookmarks(index_retained_hash)
end


def open_url(url)
  system("open #{url}") if url
end


def search_and_open(target)
  urls = @bookmark_hash['bookmarks'].select { |e| e["url"].include? target or e["tags"].include? target }
  if urls.size > 0
    open_url(urls[0]["url"])
  end
end


def open_url_from_index(index)
  open_url(@bookmark_hash['bookmarks'][index]["url"])
end


def remove_url(index)
  @bookmark_hash['bookmarks'].delete_at(index)
  true
end


def get_console_width
  console_width = `tput cols`.chomp.to_i
end


def dump_hash
  puts @bookmark_hash.inspect
end