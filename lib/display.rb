require 'terminal-table'


def list_bookmarks
  puts_bookmarks(@bookmark_hash['bookmarks'])
end


def puts_bookmarks(bookmarks)
  rows = []
  bookmarks.each_with_index { |bookmark, index| rows << ["#{index.to_s.ljust(2)} #{bookmark["url"]}", bookmark["tags"].join(", ")] }
  table = Terminal::Table.new :rows => rows,
                              :title => "bookmarks",
                              :style => {:width => get_console_width},
                              :headings => ['sites', 'tags']
  puts table
end


def puts_indexed_bookmarks(bookmarks)
  bookmarks.each do |bookmark|
    puts "#{bookmark[0]}. #{bookmark[1]}"
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