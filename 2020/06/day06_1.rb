# get intput into one string per group
lines = []
l = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  if line.length == 1 || l == ""
    lines << l if l != ""
    l = line.strip
  else
    l = l + line.strip
  end
end
file.close
lines << l if l != ""

#count unique answers per group and add to sum
sum = 0
lines.each do |l|
  sum += l.chars.to_a.uniq.length
end
puts sum