#!/bin/ruby

class Monorail
  def initialize
    @input = "input.txt"
    @lines = []
    @position = 0
    @register = {
      "a" => 0,
      "b" => 0,
      "c" => 1,
      "d" => 0
    }

  end

  def copy(x,y)
    if ["a","b","c","d"].include?(x)
      @register[y] = @register[x]
    else
      @register[y] = x.to_i
    end
    @position += 1
  end

  def increase(x)
    @register[x] += 1
    @position += 1
  end

  def decrease(x)
    @register[x] -= 1
    @position += 1
  end

  def jump(x,y)
    if @register[x] != 0
      @position += y.to_i
    else
      @position += 1
    end

  end

  def follow_instruction
    instructions = if @lines[@position][0] == "c" || @lines[@position][0] == "j"
      /(\w+) ([-,a-z,0-9]+) ([-,a-z,0-9]+)/.match(@lines[@position])
    else
      /(\w+) ([-,a-z,0-9]+)/.match(@lines[@position])
    end

    if instructions != nil
      case instructions[1]
      when "cpy"
        copy(instructions[2],instructions[3])
      when "inc"
        increase(instructions[2])
      when "dec"
        decrease(instructions[2])
      when "jnz"
        jump(instructions[2],instructions[3])
      end
    end
  end

  def get_input
    file = File.new(@input, "r")
    while (line = file.gets)
      @lines.push(line)
    end
    file.close
  end

  def solve
    @position = 0
    get_input

    while @position < @lines.length
      follow_instruction
    end

    puts @register
  end

end

monorail = Monorail.new
monorail.solve
