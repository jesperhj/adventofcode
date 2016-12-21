#!/bin/ruby

valid = (0..4294967295).to_a
puts "foo"
file = File.new("input.txt", "r")
while (line = file.gets)
  puts "line #{line}"
  input = /(\d+)-(\d+)/.match(line)
  (input[1]..input[2]).each do |x|
    valid.delete(x.to_i)
  end
end
file.close
puts "valid #{valid.first}"

# 5-8
#0-4, 9
# 0-2
# 4-7

# valid = [[0,4294967295]]
# valid = [[0,9]]
# invalid = []
# puts valid
# file = File.new("input_test.txt", "r")
# while (line = file.gets)
#   puts "line #{line}"
#   input = /(\d+)-(\d+)/.match(line)
#   low = input[1].to_i
#   high = input[2].to_i

#   valid.each do |pair|
#     if low < pair[0]
#       if
#     end
#     if pair[0] < low && pair[1] > high
#       valid.delete(pair)
#       valid.push(low, high)
#       break
#     elsif pair[0] < low && pair[1] < high
#       valid.delete(pair)
#       valid.push([pair[0], low])
#       valid.push([pair[1], high])
#     end
#   end
#   puts "#{valid}"

# end
# file.close
# puts "valid #{valid.first}"
