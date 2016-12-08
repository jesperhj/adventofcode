#!/bin/ruby

sum_of_sector_ids = 0

file = File.new("input.txt", "r")
while (line = file.gets)
  alphabet = {}
  line.strip!
  checksum = /[a-z]+/.match(/\[[a-z]+\]\z/.match(line).to_s).to_s
  line.slice!("[#{checksum}]")
  chars = line.gsub(/\-/,"").gsub(/\d*/,"")
  sector_id = /\d+/.match(line).to_s.to_i

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
  temp = []
  alphabet.sort_by {|key,value| value}.reverse.each do |k,v|
    if v != number_of_occurrence
      sorted_string += temp.sort.join
      number_of_occurrence = v
      temp.clear
    end
    temp.push(k)
  end
  sorted_string += temp.sort.join if !temp.empty?

  if sorted_string[0,checksum.length] == checksum
    sum_of_sector_ids += sector_id
  end

end
file.close

puts sum_of_sector_ids
