#!/bin/ruby

# 42154 to low
# 1423634

number_of_elves = 3017957
elves = (1..number_of_elves).to_a

elf = 0
last_elf = nil

while elves.length > 1

  # if elf % 10000 == 0
  #   print "length #{elves.length}\n"
  # elsif elves.length < 2017956
  #   print "length #{elves.length} #{elf}\n"
  # end

  break if elves.length == 1 # found answer

  if last_elf == nil
    last_elf = 0
  elsif elves[elf] == last_elf
    elf += 1
  end

  if elf > elves.length-1
    elf = 0
  end
  last_elf = elves[elf]

  if elves.length - elves.length/2 == elves.length/2 + 1 && elves.length/2 == elf
    sad_elf = elves.length-1
  elsif elves.length/2 == elf && elves.length % 2 == 0
    sad_elf = 0
  elsif elf < elves.length / 2
    sad_elf = elf + elves.length/2
  else
    if elves.length % 2 == 0
      sad_elf = elf - elves.length/2
    else
      sad_elf = elf - elves.length/2 -1
    end
    #puts "last #{elf} #{elves[elf]} - elves.length/2 #{elves.length/2}"
  end
  #puts "  ##{elf} elf #{elves[elf]} steals from #{elves[sad_elf]} #{elves}"
  elves.delete_at(sad_elf)

end

puts "answer #{elves.first}"
