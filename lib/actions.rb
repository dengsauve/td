def add_item(todo, todo_tags)
  puts "add_item todo_hash: #{@todo_hash['bookmarks'].inspect}" if @debug
  @todo_hash['items'] << {"todo": todo, "date": "", "done": false, "tags": todo_tags.to_a}
  @todo_hash['items'].uniq!
  dump_hash if @debug
  true
end


def search_hash(target)
  index_retained_hash = {}
  @todo_hash['items'].each_with_index do |e, i|
    if e["todo"].include? target or e["tags"].include? target
      index_retained_hash[i] = e["todo"]
    end
  end
  puts_indexed_items(index_retained_hash)
end


def open_url(url)
  system("open #{url}") if url
end


def search_and_open(target)
  urls = @todo_hash['bookmarks'].select { |e| e["url"].include? target or e["tags"].include? target }
  if urls.size > 0
    open_url(urls[0]["url"])
  end
end


def open_url_from_index(index)
  open_url(@todo_hash['bookmarks'][index]["url"])
end


def remove_url(index)
  @todo_hash['bookmarks'].delete_at(index)
  true
end


def get_console_width
  console_width = `tput cols`.chomp.to_i
end


def dump_hash
  puts @todo_hash.inspect
end