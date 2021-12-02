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
  :y => 0
}
commands.each do |c|
  case c[:dir]
  when "forward"
    pos[:x] += c[:move]
  when "down"
    pos[:y] += c[:move]
  when "up"
    pos[:y] -= c[:move]
  end    
end

res = pos[:x] * pos [:y]
puts res