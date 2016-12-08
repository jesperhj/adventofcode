#!/bin/ruby

number_of_triangles = 0

file = File.new("input.txt", "r")
while (line = file.gets)
  input = line.split.map! { |s| s.to_i }
  triangle = input.sort

  if triangle[0].to_i+triangle[1].to_i > triangle[2].to_i
    number_of_triangles += 1
  end
end
file.close

puts number_of_triangles
