#!/usr/bin/env ruby

require 'require_all'
require_all("#{__dir__}/lib")

@reserved_words = %w[add search ls list edit rm remove delete]
@bookmark_hash = get_hash
@debug = @bookmark_hash['debug']

puts "Retrieved bookmark hash: #{@bookmark_hash}" if @debug
puts "Arguments: #{ARGV.inspect}" if @debug


if ARGV.size > 1 and ARGV[1]
  case ARGV[0]
  when 'add'
    write_hash if add_url(ARGV[1], ARGV[2..-1])

  when 'search'
    search_hash(ARGV[1])

  when 'rm', 'remove', 'delete'
    if ARGV[1].numeric?
      write_hash if remove_url(ARGV[1].to_i)
    end

  else
    puts "You haven't entered a recognized command! Try `bm help` for more info."
  end

elsif ARGV.size == 1
  case ARGV[0]
  when 'list', 'ls'
    dump_hash if @debug
    list_bookmarks

  when 'help'
    puts_help

  else
    if ARGV[0].numeric?
      open_url_from_index(ARGV[0].to_i)
    else
      search_and_open(ARGV[0])
    end
  end

else
  puts_banner
  list_bookmarks
end
