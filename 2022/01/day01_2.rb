foods = []
food = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  if line.length <= 1
    foods << food
    food = 0
  else
    food += line.to_i
  end
end
foods << food if line != 0
file.close
puts foods.sort.reverse.first(3).inject(0, &:+)
