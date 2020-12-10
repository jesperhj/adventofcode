def get_input
  lines = []
  file = File.new("input.txt", "r")
  while (line = file.gets)  
    lines << line.to_i
  end
  file.close
  lines
end

adapters = get_input

adapters.sort!

differences = {:low => 0, :high => 1}
previous_adapter = 0

adapters.each do |a|
  if a-previous_adapter == 1
    differences[:low] += 1
  else
    differences[:high] += 1
  end
  previous_adapter = a 
end
puts differences
puts differences[:low]*differences[:high]