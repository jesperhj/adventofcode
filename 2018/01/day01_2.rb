#!/bin/ruby
sum = 0
results = {}
answer_found = false
results[0] = true


while !answer_found
  file = File.new("input.txt", "r")
  while (line = file.gets)
    sum = sum + line.to_i

    if !results[sum].nil?
      answer_found = true
      break
    else
      results[sum] = true
    end
  end
  file.close
end
puts sum

