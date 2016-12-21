password = "abcde"

class ScramblePassword

  def initialize(password)
    @password = password
    @input_file = "input_test.txt"
  end

  def swap_position(x,y)
    temp = @password[x]
    @password[x] = @password[y]
    @password[y] = temp
  end

  def swap_letter(x,y)
    (0..@password.length-1).each do |i|
      if @password[]
    end
    puts "swap letter #{x} with #{y}"
  end

  def rotate_direction(direction, steps)
    puts "rotate #{direction} steps #{steps}"
  end

  def rotate_position(x)
    puts "rotate letter #{x}"
  end

  def reverse_position(x,y)
    puts "reverse #{x} through #{y}"
  end

  def move_position(x,y)
    puts "move #{x}, #{y}"
  end

  def parse_file
    file = File.new(@input_file, "r")
    while (line = file.gets)
      puts @password
      if res = /^swap position (\d+) with position (\d+)/.match(line)
        swap_position(res[1].to_i, res[2].to_i)
      elsif res = /^swap letter (\w+) with letter (\w+)/.match(line)
        swap_letter(res[1], res[2])
      elsif res = /^rotate (left|right) (\d+)/.match(line)
        rotate_direction(res[1], res[2].to_i)
      elsif res = /^rotate based on position of letter (\w+)/.match(line)
        rotate_position(res[1])
      elsif res = /^reverse positions (\d+) through (\d+)/.match(line)
        reverse_position(res[1].to_i, res[2].to_i)
      elsif res = /^move position (\d+) to position (\d+)/.match(line)
        move_position(res[1].to_i, res[2].to_i)
      end
      puts @password
      puts ""
    end
    file.close
  end

  def solve
    parse_file
  end

end

scramble_password = ScramblePassword.new(password)
scramble_password.solve
