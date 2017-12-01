#!/bin/ruby

# 235 too high
# 236 too high

moves = ["L2", "L5", "L5", "R5", "L2", "L4", "R1", "R1", "L4", "R2", "R1", "L1", "L4", "R1", "L4", "L4", "R5", "R3", "R1", "L1", "R1", "L5", "L1", "R5", "L4", "R2", "L5", "L3", "L3", "R3", "L3", "R4", "R4", "L2", "L5", "R1", "R2", "L2", "L1", "R3", "R4", "L193", "R3", "L5", "R45", "L1", "R4", "R79", "L5", "L5", "R5", "R1", "L4", "R3", "R3", "L4", "R185", "L5", "L3", "L1", "R5", "L2", "R1", "R3", "R2", "L3", "L4", "L2", "R2", "L3", "L2", "L2", "L3", "L5", "R3", "R4", "L5", "R1", "R2", "L2", "R4", "R3", "L4", "L3", "L1", "R3", "R2", "R1", "R1", "L3", "R4", "L5", "R2", "R1", "R3", "L3", "L2", "L2", "R2", "R1", "R2", "R3", "L3", "L3", "R4", "L4", "R4", "R4", "R4", "L3", "L1", "L2", "R5", "R2", "R2", "R2", "L4", "L3", "L4", "R4", "L5", "L4", "R2", "L4", "L4", "R4", "R1", "R5", "L2", "L4", "L5", "L3", "L2", "L4", "L4", "R3", "L3", "L4", "R1", "L2", "R3", "L2", "R1", "R2", "R5", "L4", "L2", "L1", "L3", "R2", "R3", "L2", "L1", "L5", "L2", "L1", "R4"]
#moves = ["R8", "R4", "R4", "R8"]

class BunnyHQWalker
  def initialize
    @current_direction = :north
    @stack = {
      :north => 0,
      :south => 0,
      :east => 0,
      :west => 0
    }
    @pos = {
      :x => 0,
      :y => 0
    }
    @map = { 0 => { 0 => 0}}
    @steps_made = 0
    @max = { :x_min => 0, :x_max => 0, :y_min => 0, :y_max => 0}
  end


  def turn(direction, move)
    case @current_direction
    when :north
      @current_direction = (direction == :left) ? :west : :east
    when :south
      @current_direction = (direction == :left) ? :east : :west
    when :east
      @current_direction = (direction == :left) ? :north : :south
    when :west
      @current_direction = (direction == :left) ? :south : :north
    end
  end

  def walk(steps)

    #if steps.to_i == 193
    #  puts "steps #{@steps_made}"
    #end

    @stack[@current_direction] += steps.to_i

    (0..steps.to_i-1).each do |i|
      @steps_made += 1

      case @current_direction
      when :north
        @pos[:y] += 1
        @max[:y_max] = @pos[:y] if @pos[:y] > @max[:y_max]
      when :south
        @pos[:y] -= 1
        @max[:y_min] = @pos[:y] if @pos[:y] < @max[:y_min]
      when :east
        @pos[:x] += 1
        @max[:x_max] = @pos[:x] if @pos[:x] > @max[:x_max]
      when :west
        @pos[:x] -= 1
        @max[:x_min] = @pos[:x] if @pos[:x] < @max[:x_min]
      end

      if @map[@pos[:x]] != nil && @map[@pos[:x]][@pos[:y]] != nil
        puts "Answer #{@pos} #{@map[@pos[:x]][@pos[:y]]}"
        return -1
      end

      @map[@pos[:x]] = {} if @map[@pos[:x]] == nil
      @map[@pos[:x]][@pos[:y]] = @steps_made

    end
  end

  def print_map
    (@max[:x_min]..@max[:x_max]).each  do |x|
      line = ""
      (@max[:y_min]..@max[:y_max]).each  do |y|
        if x == 0 && y == 0
          line += "0"
        else
          line += @map[x] != nil && @map[x][y] != nil ? "x" : "."
        end
      end
      puts "#{line}"
    end
  end
end

bunny_walker = BunnyHQWalker.new

moves = []
file = File.new("input.txt", "r")
  while (line = file.gets)
    moves = line.split(', ')
    puts "#{moves}"
  end
file.close

# Traverse through all movements
moves.each do |move|
  move[0] == "L" ? bunny_walker.turn(:left, move) : bunny_walker.turn(:right, move)
  break if bunny_walker.walk(move[1, move.length]) == -1
end
bunny_walker.print_map

