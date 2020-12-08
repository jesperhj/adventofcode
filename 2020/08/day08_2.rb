lines = []
l = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  operation, argument = line.strip.split
  lines << {:opr => operation, :arg => argument.to_i}
end
file.close

def execute_program(lines)
  accumulator = 0
  executed_instructions = []
  current_instruction = 0

  while true  
    if executed_instructions.include? current_instruction      
      return 0
      break
    else
      executed_instructions << current_instruction
    end
    break if current_instruction >= lines.length

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
  
  return accumulator
end


for i in 0..lines.length-1 do
  next if lines[i][:opr] == "acc"
  lines[i][:opr] = (lines[i][:opr] == "jmp") ? "nop" : "jmp"
  res = execute_program(lines)
  lines[i][:opr] = (lines[i][:opr] == "jmp") ? "nop" : "jmp"
  if res > 0
    puts res
    break
  end
end
