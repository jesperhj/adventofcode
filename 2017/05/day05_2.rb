#!/bin/ruby

message = []
file = File.new("input.txt", "r")
while (line = file.gets)
  message.push(line.strip.to_i)
end
file.close

steps = 0
current_pos = 0

while message[current_pos] != nil
  steps += 1
  old_pos = current_pos

  if message[current_pos] != 0
    current_pos = current_pos + message[current_pos]
  end

  message[old_pos] += message[old_pos] >= 3 ? -1 : 1

end
puts steps
