lines = []
file = File.new("input.txt", "r")
while (line = file.gets)
  l = line.split
  password = {}
  password["min"], password["max"] = l[0].split("-")
  password["check"], password["pwd"] = l[1][0], l[2]
  lines.push(password)
end
file.close

valid_passwords = 0
lines.each do |line|
  if((line["pwd"][line["min"].to_i-1] == line["check"]) !=
    (line["pwd"][line["max"].to_i-1] == line["check"]))
    valid_passwords += 1
  end
end

puts(valid_passwords)