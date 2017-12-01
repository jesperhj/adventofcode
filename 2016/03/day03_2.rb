#!/bin/ruby

number_of_triangles = 0

file = File.new("input.txt", "r")
lines_read = 0

temp_storage = []

while (line = file.gets)
  lines_read += 1
  row = line.split.map! { |s| s.to_i }
  temp_storage.push(row)

  # every third line, check the three vertical available triangles
  if lines_read % 3 == 0
    (0..2).each do |column|
      triangle = [temp_storage[0][column], temp_storage[1][column], temp_storage[2][column]].sort
      if triangle[0] + triangle[1] > triangle[2]
        number_of_triangles += 1
      end
    end
    temp_storage.clear
  end
end
file.close

puts number_of_triangles
