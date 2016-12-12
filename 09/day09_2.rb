#!/bin/ruby

decompression_length = 0
marker_states = [:length_to_repeat, :times_to_repeat, :getting_chars_to_repeat, :looking_for_marker]


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
  decompressed_line = ""
  position = 0
  state = :looking_for_marker
  length_to_repeat = ""
  times_to_repeat = ""
  chars_to_repeat = ""

  line.strip.each_char do |char|

    if state == :looking_for_marker
      if found_start_marker(char)
        state = :length_to_repeat
      else
        decompressed_line += char
      end
    else
      if state == :times_to_repeat && found_end_marker(char)
        state = :getting_chars_to_repeat
      elsif state == :length_to_repeat && switch_to_repeat_to(char)
        state = :times_to_repeat
      elsif state == :length_to_repeat
        length_to_repeat += char
      elsif state == :times_to_repeat
        times_to_repeat += char
      elsif state == :getting_chars_to_repeat
        chars_to_repeat += char
        # Are we ready to decompress?
        if chars_to_repeat.length == length_to_repeat.to_i
          puts "#{length_to_repeat}x#{times_to_repeat}"
          (1..times_to_repeat.to_i).each { decompressed_line += chars_to_repeat }
          state = :looking_for_marker
          length_to_repeat = ""
          times_to_repeat = ""
          chars_to_repeat = ""
        end
      end
    end
    position += 0
  end
  return decompressed_line
end


file = File.new("input.txt", "r")
while (line = file.gets)

  while line.count("(") > 0
    puts line.count("(")
    line = decompress(line)
  end
  puts line.length
  decompression_length += line.length
end
file.close

puts decompression_length
