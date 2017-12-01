#!/bin/ruby

class Discs
  def initialize
    @discs = {}
    @time = 0
  end

  def parse_disc(line)
    input = /Disc #(\d+) has (\d+) positions; at time=(\d+), it is at position (\d+)./.match(line)
    @discs[input[1].to_i] = { :start_position => input[4].to_i, :number_of_positions => input[2].to_i, :turns => 0, :id => input[1].to_i}
  end

  def get_input
    file = File.new("input.txt", "r")
    while (line = file.gets)
      parse_disc(line)
    end
    file.close
  end

  def turns_per_disc
    @discs.each do |k,v|
      @discs[k][:turns] = (v[:number_of_positions] - v[:start_position]) % v[:number_of_positions]
    end
  end

  def solve
    turns_per_disc
    start_time = 0
    time = 0
    number_of_discs = @discs.size
    no_solution = true

    while no_solution
      no_solution = false
      start_time = time
      @discs.each do |k,v|
        time += 1
        foo = (v[:start_position] + time) % v[:number_of_positions]
        if ((v[:start_position] + time) % v[:number_of_positions]) != 0
          no_solution = true
          break
        end
      end
    end
    puts start_time

  end
end

discs = Discs.new
discs.get_input
discs.solve
