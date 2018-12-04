#!/bin/ruby
sum = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  sum = sum + line.to_i
end
puts sum
file.close
