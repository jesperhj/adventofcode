#!/bin/ruby

verified_ips = 0

def find_bab(aba, line)
  bab = ["", "", ""]
  bab_location = 0
  line.each_char do |char|
    bab.shift
    bab.push(char)
    case char
    when "["
     bab_location += 1
    when "]"
     bab_location -= 1
    else
      if bab_location == 1 && aba[0] == bab[1] && aba[2] == bab[1] && aba[1] == bab[0] && aba[1] == bab[2]
        return true
      end
    end
  end
  return false
end

file = File.new("input.txt", "r")
while (line = file.gets)
  location = 0
  aba = ["", "", ""]
  found_abba = false
  invalid = false
  line.each_char do |char|
    aba.shift
    aba.push(char)
    case char
    when "["
     location += 1
    when "]"
     location -= 1
    else
      if location == 0 && find_bab(aba, line)
        verified_ips += 1
        break
      end
    end
  end
end
file.close

puts verified_ips
