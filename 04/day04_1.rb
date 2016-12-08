#!/bin/ruby

number_of_correct_rooms = 0

file = File.new("input.txt", "r")
while (line = file.gets)
  alphabet = {}
  line.strip!
  checksum = /[a-z]+/.match(/\[[a-z]+\]\z/.match(line).to_s).to_s
  line.slice!("[#{checksum}]")
  chars = line.gsub(/\-/,"").gsub(/\d*/,"")

  chars.each_char do |char|
    if alphabet.has_key?(char)
      alphabet[char] += 1
    else
      alphabet[char] = 1
    end
  end

  # todo order ties in alphabetical order
  sorted_string = ""
  number_of_occurrence = 0
  temp = ""
  alphabet.sort_by {|key,value| value}.reverse.each do |k,v|
    sorted_string += k
    if v == number_of_occurrence
  end

  if sorted_string[0,checksum.length] == checksum
    number_of_correct_rooms += 1
  end

end
file.close

puts number_of_correct_rooms
