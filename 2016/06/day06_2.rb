#!/bin/ruby

input = {
    0 => {}, 1 => {}, 2 => {}, 3 => {}, 4 => {}, 5 => {}, 6 => {}, 7 => {}
}

file = File.new("input.txt", "r")
while (line = file.gets)
  i = 0
  line.strip.each_char do |char|
    input[i][char] = (input[i][char] == nil) ? 1 : (input[i][char] + 1)
    i += 1
  end

end
file.close
puts input
answer = ""
input.each do |k,v|
  answer += v.sort_by{|k, v| v}.first.first
end
puts answer