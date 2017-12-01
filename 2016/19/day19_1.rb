#!/bin/ruby

number_of_elves = 3017957
elves = (1..number_of_elves).to_a

while elves.length > 1
  length = elves.length
  (0..length).each do |elf|
    next if elf % 2 == 1
    if elf == (length -1)
      elves[0] = nil
    else
      elves[elf+1] = nil
    end
  end
  elves.delete(nil)
end

puts "answer #{elves.first}"
