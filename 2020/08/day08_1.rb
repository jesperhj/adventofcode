lines = []
l = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  operation, argument = line.strip.split
  lines << {:opr => operation, :arg => argument.to_i}
end
file.close

accumulator = 0
executed_instructions = []
current_instruction = 0

while true  
  if executed_instructions.include? current_instruction
    break
  else
    executed_instructions << current_instruction
  end

  instruction = lines[current_instruction]
  case instruction[:opr]
  when "acc"
    accumulator += instruction[:arg]
    current_instruction += 1
  when "jmp"
    current_instruction += instruction[:arg]
  when "nop"
    current_instruction += 1
  end
end

puts accumulator