#!/bin/ruby
require 'digest/md5'

pos = {:x => 0, :y => 0}
stack = ""
input = "awrkjxxr"

class TwoStep
  def initialize
    @md5 = Digest::MD5.new
    @best_solution = nil
    @moves = ["b","c","d","e","f"]
  end

  def hash(data)
    @md5.hexdigest(data)
  end

  def at_finish(pos)
    pos[:x] == 3 && pos[:y] == 3
  end

  def print_result
    puts "SOLUTION: #{@best_solution.length}"
  end

  def solve(input, stack, pos)
    if at_finish(pos)
      if @best_solution == nil || @best_solution.length < stack.length
        @best_solution = stack
      end
      return
    end

    next_input = hash(input+stack)

    # up
    if pos[:y] > 0 && @moves.include?(next_input[0])
      solve(input, stack+"U", {:x => pos[:x], :y => pos[:y]-1})
    end
    # down
    if pos[:y] < 3 && @moves.include?(next_input[1])
      solve(input, stack+"D", {:x => pos[:x], :y => pos[:y]+1})
    end
    # left
    if pos[:x] > 0 && @moves.include?(next_input[2])
      solve(input, stack+"L", {:x => pos[:x]-1, :y => pos[:y]})
    end
    # right
    if pos[:x] < 3 && @moves.include?(next_input[3])
      solve(input, stack+"R", {:x => pos[:x]+1, :y => pos[:y]})
    end
  end

end

two_step = TwoStep.new
two_step.solve(input, stack, pos)
two_step.print_result