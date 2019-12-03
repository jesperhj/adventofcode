total_fuel = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  total_fuel +=  ( line.to_i / 3 ) - 2
end
file.close
puts total_fuel
