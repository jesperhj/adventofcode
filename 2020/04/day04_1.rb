lines = []
l = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  if line.length == 1 || l == ""
    lines << l if l != ""
    l = line.strip
  else
    l = l + " " + line.strip
  end
end
file.close
lines << l if l != ""

valid_passports = 0
lines.each do |l|
  if l.split.length == 8 || (l.split.length == 7 && !l.include?("cid"))
    valid_passports += 1
  end
end

puts valid_passports