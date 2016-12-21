#!/bin/ruby
#4294967295
# 22939479 to low

lines = []
file = File.new("input.txt", "r")
  while (line = file.gets)
    l = line.chomp.split(/-/)
    lines.push([l[0].to_i, l[1].to_i])
  end
file.close

lowest_number = 0
lines.sort.each do |line|
  puts "#{lowest_number} - #{line}"
  if lowest_number >= line[0] && lowest_number <= line[1]
    lowest_number = line[1]+1
  elsif lowest_number < line[0]
    puts "Loweset number #{lowest_number}"
    break
  end
end