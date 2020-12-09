def get_input
  lines = []
  file = File.new("input.txt", "r")
  while (line = file.gets)  
    lines << line.to_i
  end
  file.close
  lines
end

def find_number(numbers, preamble)
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
      return numbers[i]
    end    
  end
  return 0
end

def find_encryption_weakness(numbers, number)
  for i in 0..numbers.index(number)-1
    contiguous_set = []
    for j in i..numbers.index(number)-1
      contiguous_set << numbers[j]
      break if contiguous_set.sum > number
      if contiguous_set.sum == number
        contiguous_set.sort!
        return contiguous_set.sort.first + contiguous_set.last
      end
    end
  end
  return 0
end

preamble = 25
numbers = get_input
number = find_number(numbers, preamble)
weakness = find_encryption_weakness(numbers,number)
puts weakness
