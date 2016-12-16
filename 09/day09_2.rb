#!/bin/ruby

# 22190123 low

decompression_length = 0
marker_states = [:length_to_repeat, :times_to_repeat, :fast_forward, :looking_for_marker]


def found_start_marker(char)
  char == "("
end

def found_end_marker(char)
  char == ")"
end

def switch_to_repeat_to(char)
  char == "x"
end

def decompress(line)
  decompressed_length = 0
  position = 0
  state = :looking_for_marker
  length_to_repeat = ""
  times_to_repeat = ""
  chars_to_repeat = ""
  ignore = 0

  (0..line.length-1). each do |i|
    char = line[i]
    if state == :fast_forward
      ignore -= 1
      state = :looking_for_marker if ignore == 0
    elsif state == :looking_for_marker
      if found_start_marker(char)
        state = :length_to_repeat
      else
        decompressed_length += 1
      end
    else
      if found_end_marker(char)
        new_line = line[i+1..i+length_to_repeat.to_i]
        res = times_to_repeat.to_i * decompress(new_line)
        decompressed_length += res
        state = :fast_forward
        ignore = length_to_repeat.to_i
        length_to_repeat = ""
        times_to_repeat = ""
        chars_to_repeat = ""
      elsif switch_to_repeat_to(char)
        state = :times_to_repeat
      elsif state == :times_to_repeat
        times_to_repeat += char
      elsif state == :length_to_repeat
        length_to_repeat += char
      end
    end
  end
  return decompressed_length
end


file = File.new("input.txt", "r")
while (line = file.gets)
  decompression_length = decompress(line)
  puts "#{decompression_length-1}"
end
file.close

