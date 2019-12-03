
def calculate_fuel(mass)
	fuel = (mass / 3 ) - 2
	return 0 if fuel < 0
	return fuel > 0 ? fuel + calculate_fuel(fuel) : fuel
end


total_fuel = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  total_fuel +=  calculate_fuel(line.to_i)
end
file.close
puts total_fuel
