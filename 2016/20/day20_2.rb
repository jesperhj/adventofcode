#!/bin/ruby

lines = []
file = File.new("input.txt", "r")
  while (line = file.gets)
    l = line.chomp.split(/-/)
    lines.push([l[0].to_i, l[1].to_i])
  end
file.close

contender = 0
number_of_ips = 0
lines.sort.each do |line|
  puts "#{contender} - #{line}"
  if contender >= line[0] && contender <= line[1]
    contender = line[1]+1
  elsif contender < line[0]
    number_of_ips += line[0]-contender
    contender = line[1]+1
  end
end

puts number_of_ips