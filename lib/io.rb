require 'json'

def get_hash
  path = "#{__dir__}/../items.json"
  if File.exist?(path)
    file = File.read(path)
    puts "file: #{file}" if @debug
    return JSON.parse(file)
  end

  {
      "todo" => [],
      "date" => "",
      "done" => false,
      "tags" => []
  }
end

def write_hash
  File.write("#{__dir__}/../items.json", JSON.dump(@todo_hash))
end