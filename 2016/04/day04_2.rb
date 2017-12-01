#!/bin/ruby

sum_of_sector_ids = 0


def rotate_room(encrypted_name, sector_id)
  alphabet_size = 26
  decrypted_name = ""

  encrypted_name.each_char do |char|
    if char == "-"
      decrypted_name += " "
    else
      decrypted_name += (((char.ord - "a".ord + sector_id) % alphabet_size) + "a".ord).chr
    end
  end
  puts "#{decrypted_name} #{sector_id}"
end

file = File.new("input.txt", "r")
while (line = file.gets)
  alphabet = {}
  line.strip!
  checksum = /[a-z]+/.match(/\[[a-z]+\]\z/.match(line).to_s).to_s
  line.slice!("[#{checksum}]")
  chars = line.gsub(/\-/,"").gsub(/\d*/,"")
  sector_id = /\d+/.match(line).to_s.to_i

  rotate_room(line.gsub(/\d*/,""), sector_id)

end
file.close

