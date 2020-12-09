def get_input
  lines = []
  file = File.new("input.txt", "r")
  while (line = file.gets)  
    lines << line.to_i
  end
  file.close
  lines
end

preamble = 25
numbers = get_input

for i in preamble..numbers.length-1
  matched = false

  for j in i-preamble..i-1
    for k in i-preamble..i-1      
      if numbers[j] != numbers[k] && numbers[j]+numbers[k] == numbers[i]        
        matched = true
      end
    end    
  end
  if !matched
    puts numbers[i]
    break
  end  
end