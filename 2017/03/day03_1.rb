#!/bin/ruby

input = 265149

levels = 1
pre_lower_left = 0
lower_left = 1
while lower_left < input
  pre_lower_left = lower_left
  lower_left += 8*levels
  levels += 1
end
side_size = levels*2-2

side = 1
corner = pre_lower_left+side_size*side
while pre_lower_left+side_size*side < input
  side +=1
  corner = pre_lower_left+side_size*side
end

# corner
if input == corner
  puts "#{input} is corner"
  puts "Answer = #{(levels-1)*2}"
elsif input == corner-side_size/2
  puts "#{input} is shortcut"
  puts "Answer = #{(levels-1)}"
else
  puts "#{input} is long"
  puts "Answer = #{(levels-1)+(input-(corner-side_size/2)).abs}"
end
