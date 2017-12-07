#!/bin/ruby

passwords = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  words = []
  line.strip.split(" ").each do |w|
    words.push(w.chars.sort.join)
  end
  passwords += words.size == words.uniq.size ? 1 : 0
end
file.close
puts passwords
