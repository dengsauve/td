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


def mark_done(index)
  @todo_hash['items'][index]['done'] = true
  @todo_hash['items'][index]['date'] = Time.new.strftime('%Y-%m-%d')
  true
end


def search_and_mark_done(target)
  @todo_hash['items'].each_with_index do |e, i|
    if e["todo"].include? target or e["tags"].include? target
      mark_done(i)
      return true
    end
  end

  false
end


def remove_item(index)
  @todo_hash['items'].delete_at(index)
  true
end


def get_console_width
  console_width = `tput cols`.chomp.to_i
end


def dump_hash
  puts @todo_hash.inspect
end