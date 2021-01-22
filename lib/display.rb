require 'terminal-table'
require 'json'


def outstanding_items
  @todo_hash['items'].reject{ |e| e['done'] == true}
end


def list_items
  puts_items(outstanding_items)
end


def puts_items(items)
  rows = []
  items.each_with_index do |item, index|
    rows << ["#{index.to_s.ljust(2)} #{item["todo"]}", item["tags"].join(", ")]
  end
  table = Terminal::Table.new :rows => rows,
                              :title => "items",
                              :style => {:width => get_console_width},
                              :headings => ['items', 'tags']
  puts table
end


def puts_indexed_items(items)
  items.each do |item|
    puts "#{item[0]}. #{item[1]}"
  end
end


def puts_help
  puts "bm: A bookmark utility

usage: bm [add|search|[rm|remove|delete]|[ls|list]|[help]

example:
  bm add https://www.google.com
  bm search google
  bm goog
    this would open a the first bookmark to contain the string 'goog'

created by https://github.com/dengsauve/bm
"
end


def puts_banner
  banner_lines = open("#{__dir__}/../banner.txt").readlines
  banner_lines.each do |line|
    puts line.chomp.center(get_console_width)
  end
end


def puts_history
  history_array = @todo_hash['items'].sort_by{ |i| i['date']}.reverse.group_by{ |i| i['date']}

  history_array.each do |date|
    next if date[0] == ""
    puts date[0]
    date[1].each do |item|
      puts "* #{item['todo']}"
    end
    puts "\n"
  end
end