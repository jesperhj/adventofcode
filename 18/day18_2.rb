#!/bin/ruby

def is_trap(title)
  title == "^"
end

def print_map(rows)
  rows.each do |row|
    puts "#{row}"
  end
end

def count_safe_tiles(row)
  safe_tiles = 0
  row.each_char do |tile|
    safe_tiles += 1 if !is_trap(tile)
  end
  return safe_tiles
end

start_row  = "^.^^^..^^...^.^..^^^^^.....^...^^^..^^^^.^^.^^^^^^^^.^^.^^^^...^^...^^^^.^.^..^^..^..^.^^.^.^......."
new_row = start_row.clone
safe_tiles = count_safe_tiles(start_row)
number_of_rows = 400000

rows = [start_row]
(1..number_of_rows-1).each do |row|
  (0..start_row.length-1).each do |column|

    left   = (column == 0) ? "." : start_row[column-1]
    center = start_row[column]
    right  = (column == start_row.length-1) ? "." : start_row[column+1]

    if is_trap(left) && is_trap(center) && !is_trap(right) ||
      !is_trap(left) && is_trap(center) && is_trap(right) ||
      is_trap(left) && !is_trap(center) && !is_trap(right) ||
      !is_trap(left) && !is_trap(center) && is_trap(right)
      new_row[column] = "^"
    else
      new_row[column] =  "."
      safe_tiles += 1
    end
  end
  start_row = new_row.clone
end
puts "safe tiles #{safe_tiles}"
