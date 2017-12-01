#!/bin/ruby

start = [1,1]

# 440 high
# 123 low

class Maze
  def initialize
    @favorite_number = 1350
    @goal = [31,39]
    @been = {}
    @result = nil
    @number_of_steps = 0
    @max_steps = 50
  end

  def open_space?(x,y)
    res = (x*x + 3*x + 2*x*y + y + y*y + @favorite_number).to_s(2)
    bits = 0
    res.each_char do |bit|
      bits += 1 if bit == "1"
    end
    bits % 2 == 0
  end

  def available_spaces(x,y)
    res = []
    res.push([x,y+1]) if open_space?(x,y+1)
    res.push([x,y-1]) if y-1 >= 0 && open_space?(x,y-1)
    res.push([x+1,y]) if open_space?(x+1,y)
    res.push([x-1,y]) if x-1 >= 0 && open_space?(x-1,y)
    res
  end

  def found_goal(choices)
    choices.each do |choice|
      return true if choice[0] == @goal[0] && choice[1] == @goal[1]
    end
    return false
  end

  def been_here(x,y, steps)
    @been.each do |k,v|
      if k == "#{x},#{y}" && v < steps
        return true
      end
    end
    return false
  end

  def find_path(x,y, steps)
    if been_here(x,y, steps) || steps > @max_steps
      return
    else
      @been["#{x},#{y}"] = steps
    end

    if x > @goal[0]*2 || y > @goal[1]*2
      return
    end

    choices = available_spaces(x,y)

    if found_goal(choices)
      if @result == nil || steps+1 < @result
        @result = steps + 1
      end
    end

    choices.each do |choice|
      find_path(choice[0], choice[1], steps+1)
    end
  end

  def get_result
    puts "been #{@been.length} #{@been}"
  end
end

maze = Maze.new
maze.find_path(1,1,0)
maze.get_result
