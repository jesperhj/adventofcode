commands = []
file = File.new("input.txt", "r")
while (line = file.gets)
  line = line.split
  commands.push({
    :dir => line[0],
    :move => line[1].to_i
  })
end
file.close

pos = {
  :x => 0,
  :y => 0,
  :aim => 0,
}
commands.each do |c|
  case c[:dir]
  when "forward"
    pos[:x] += c[:move]
    pos[:y] += c[:move]*pos[:aim]
  when "down"
    pos[:aim] += c[:move]
  when "up"
    pos[:aim] -= c[:move]
  end
  puts pos 
end

res = pos[:x] * pos [:y]
puts res