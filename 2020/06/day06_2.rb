# get intput into one string per group
lines = []
l = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  if line.length == 1 || l == ""
    lines << l if l != ""
    l = line.strip
  else
    l = l + " " +line.strip
  end
end
file.close
lines << l if l != ""

# get size of group and match number of similar answers with group size
sum = 0
lines.each do |l|
  group_size = l.split.length
  yes_from_whole_group = l.split(//).find_all do |c|
    l.count(c) == group_size
  end
  sum += yes_from_whole_group.uniq.length
end
puts sum