#!/bin/ruby

verified_ips = 0

def verify_tls(ip)
  ip[0] == ip[3] && ip[1] == ip[2] && ip[0] != ip[1]
end

file = File.new("input.txt", "r")
while (line = file.gets)
  location = 0
  abba = ["", "", "", ""]
  found_abba = false
  invalid = false
  line.each_char do |char|
    abba.shift
    abba.push(char)
    case char
    when "["
     location += 1
    when "]"
     location -= 1
    else
      invalid = true    if location != 0 && verify_tls(abba)
      found_abba = true if location == 0 && verify_tls(abba)
    end
  end
  verified_ips += 1 if !invalid && found_abba
end
file.close

puts verified_ips
