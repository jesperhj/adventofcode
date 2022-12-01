max = 0
food = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  if line.length <= 1
    max = food if food > max
    food = 0
  else
    food += line.to_i
  end
end
max = food if food !=0 && food > max
file.close
puts max
