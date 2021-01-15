#!/usr/bin/env ruby

require 'require_all'
require_all("#{__dir__}/lib")

@reserved_words = %w[add search ls list edit rm remove delete]
@todo_hash = get_hash
@debug = @todo_hash['debug']

puts "Retrieved todo hash: #{@todo_hash}" if @debug
puts "Arguments: #{ARGV.inspect}" if @debug


if ARGV.size > 1 and ARGV[1]
  case ARGV[0]
  when 'add'
    write_hash if add_item(ARGV[1], ARGV[2..-1])

  when 'search'
    search_hash(ARGV[1])

  when 'rm', 'remove', 'delete'
    if ARGV[1].numeric?
      write_hash if remove_item(ARGV[1].to_i)
    end

  else
    puts "You haven't entered a recognized command! Try `bm help` for more info."
  end

elsif ARGV.size == 1
  case ARGV[0]
  when 'list', 'ls'
    dump_hash if @debug
    list_items

  when 'help'
    puts_help

  else
    if ARGV[0].numeric?
      write_hash if mark_done(ARGV[0].to_i)
    else
      write_hash if search_and_mark_done(ARGV[0])
    end
  end

else
  puts_banner
  list_items
end
