#!/bin/ruby

# 49 low

class SafeCracking
  def initialize
    @input = "input.txt"
    @lines = []
    @instructions = {}
    @position = 0
    @register = {
      "a" => 12,
      "b" => 0,
      "c" => 0,
      "d" => 0
    }
  end

  def copy(x,y)
    if ["a","b","c","d"].include?(y)
      if ["a","b","c","d"].include?(x)
        @register[y] = @register[x]
      else
        @register[y] = x.to_i
      end
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
      steps = y.to_i == 0 ? @register[y] : y.to_i
      @position += steps
    else
      @position += 1
    end
  end

  def toggle(x)
    position = @position + @register[x].to_i
    instruction = @instructions[position]

    @position += 1

    if position > @instructions.length
      return
    end

    if instruction != nil
      case instruction[:instruction]
      when :cpy
        @instructions[position] = {:instruction => :jnz, :params => [instruction[:params][0],instruction[:params][1]]}
      when :inc
        @instructions[position] = {:instruction => :dec, :params => [instruction[:params][0]]}
      when :dec
        @instructions[position] = {:instruction => :inc, :params => [instruction[:params][0]]}
      when :jnz
        @instructions[position] = {:instruction => :cpy, :params => [instruction[:params][0],instruction[:params][1]]}
      when :tgl
        @instructions[position] = {:instruction => :inc, :params => [instruction[:params][0]]}
      end
    end

  end

  def follow_instruction
    instruction = @instructions[@position]

    if instruction != nil
      case instruction[:instruction]
      when :cpy
        copy(instruction[:params][0],instruction[:params][1])
      when :inc
        increase(instruction[:params][0])
      when :dec
        decrease(instruction[:params][0])
      when :jnz
        jump(instruction[:params][0],instruction[:params][1])
      when :tgl
        toggle(instruction[:params][0])
      end
    end
  end

  def save_to_instructions
    (0..@lines.length-1).each do |line|
      instructions = if @lines[line][0] == "c" || @lines[line][0] == "j"
        /(\w+) ([-,a-z,0-9]+) ([-,a-z,0-9]+)/.match(@lines[line])
      else
        /(\w+) ([-,a-z,0-9]+)/.match(@lines[line])
      end

      if instructions != nil
        case instructions[1]
        when "cpy"
          @instructions[line] = {:instruction => :cpy, :params => [instructions[2],instructions[3]]}
        when "inc"
          @instructions[line] = {:instruction => :inc, :params => [instructions[2]]}
        when "dec"
           @instructions[line] = {:instruction => :dec, :params => [instructions[2]]}
        when "jnz"
          @instructions[line] = {:instruction => :jnz, :params => [instructions[2],instructions[3]]}
        when "tgl"
          @instructions[line] = {:instruction => :tgl, :params => [instructions[2]]}
        end
      end

    end

  end

  def get_input
    file = File.new(@input, "r")
    while (line = file.gets)
      @lines.push(line.chomp)
    end
    file.close
  end

  def solve
    @position = 0
    get_input
    save_to_instructions
    i = 0
    while @position < @instructions.length
      follow_instruction
      if i % 1000000 == 0
        puts "#{i} pos #{@position}"
        puts "#{@register}\n\n"
      end
      i += 1
    end

    puts @register
  end

end

safe_cracking = SafeCracking.new
safe_cracking.solve
