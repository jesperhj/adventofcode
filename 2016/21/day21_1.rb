password = "abcdefgh"

class ScramblePassword

  def initialize(password)
    @password = password
    @input_file = "input.txt"
  end

  def swap_position(x,y)
    temp = @password[x]
    @password[x] = @password[y]
    @password[y] = temp
  end

  def swap_letter(x,y)
    (0..@password.length-1).each do |i|
      if @password[i] == x
        @password[i] = y
      elsif @password[i] == y
        @password[i] = x
      end
    end
  end

  def rotate_direction(direction, steps)
    @password = @password.split(//).rotate(steps * (direction == "right" ? -1 : 1)).join
  end

  def rotate_position(x)
    position = (@password =~ /#{x}/).to_i
    positions = -1*(1 + position + (position >= 4 ? 1 : 0))
    @password = @password.split(//).rotate(positions).join
  end

  def reverse_position(x,y)
    pre = (x > 0) ? @password[0..x-1] : ""
    to_reverse = @password[x..y]
    post = (y < @password.length-1) ? @password[y+1, @password.length] : ""
    @password = pre + to_reverse.reverse + post
  end

  def move_position(x,y)
    to_move = @password[x]
    @password.slice!(x)
    pre = (y > 0) ? @password[0..y-1] : ""
    post = (y < @password.length) ? @password[y, @password.length - y] : ""
    @password = pre + to_move + post
  end

  def parse_file
    file = File.new(@input_file, "r")
    while (line = file.gets)
      #puts line
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
    end
    file.close
  end

  def solve
    parse_file
    puts @password
  end

end

scramble_password = ScramblePassword.new(password)
scramble_password.solve
