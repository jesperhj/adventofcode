#!/bin/ruby

# 42154 to low

number_of_elves = 3017957
elves = (1..number_of_elves).to_a

while elves.length > 1
  length = elves.length
  (0..elves.length).each do |elf|
    break if elf > elves.length-1 || elves.length == 1
    if elf % 10000 == 0
      puts "-elf #{elf} length #{elves.length}-"
    end
    if elves.length - elves.length/2 == elves.length/2 + 1 && elves.length/2 == elf
      #puts "="
      sad_elf = elves.length-1
    elsif elf < elves.length / 2
      #puts "first"
      sad_elf = elf + elves.length/2
    else
      #puts "last"
      sad_elf = elf - elves.length/2 -1
    end
    #puts "  elf #{elves[elf]} stelas from #{elves[sad_elf]}"
    elves.delete_at(sad_elf)
  end
  #puts "#{elves} are left"
end

puts "answer #{elves.first}"
