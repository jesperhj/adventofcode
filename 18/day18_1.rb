#!/bin/ruby
# 4907 high

def is_trap(title)
  title == "^"
end

def print_map(rows)
  rows.each do |row|
    puts "#{row}"
  end
end

def count_safe_tiles(rows)
  safe_tiles = 0
  rows.each do |row|
    row.each_char do |tile|
      safe_tiles += 1 if !is_trap(tile)
    end
  end
  return safe_tiles
end
start_row = "^.^^^..^^...^.^..^^^^^.....^...^^^..^^^^.^^.^^^^^^^^.^^.^^^^...^^...^^^^.^.^..^^..^..^.^^.^.^......."
number_of_rows = 40

rows = [start_row]

(1..number_of_rows-1).each do |row|
  new_row = ""
  (0..start_row.length-1).each do |column|

    left   = (column == 0) ? "." : rows[row-1][column-1]
    center = rows[row-1][column]
    right  = (column == start_row.length-1) ? "." : rows[row-1][column+1]

    if is_trap(left) && is_trap(center) && !is_trap(right) ||
      !is_trap(left) && is_trap(center) && is_trap(right) ||
      is_trap(left) && !is_trap(center) && !is_trap(right) ||
      !is_trap(left) && !is_trap(center) && is_trap(right)
      new_row += "^"
    else
      new_row += "."
    end
  end
  rows.push(new_row)
end

print_map(rows)
puts "safe tiles #{count_safe_tiles(rows)}"
