#!/bin/ruby

class GridComputing
  def initialize
    @nodes = {}
    @number_of_pairs = 0
    @min_x = 0
    @max_x = 0
    @min_y = 0
    @max_y = 0
  end

  def load_input
    file = File.new("input.txt", "r")
      while (line = file.gets)
        next unless line[0] == "/"
        input = /^\/dev\/grid\/node-x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T\s*(\d+)T\s*(\d+)%/.match(line)
        @nodes[[input[1].to_i,input[2].to_i]] = {
          :size   => input[3].to_i,
          :used   => input[4].to_i,
          :avail  => input[5].to_i,
          :use    => input[6].to_i
        }
      #TODO set min and max
      end
    file.close
  end

  def to_print(k,v)
    if v[:used] == 0
      " _ "
    elsif k[0] == 0 && k[1] == 0
      "(.)"
    else
      " . "
    end
  end

  def print
    x = 0
    line = ""
    @nodes.each do |k,v|
      if k[0] == x
        line += to_print(k,v)
      else
        puts line
        line = to_print(k,v)
        x = k[0]
      end
    end
  end

  def move_data()
  end

  def done(node)
    node[0] == 0 && node[1] == 0 #&& TODO check storage
  end

  def solve_inner(node, steps)
    if node[-]
    if node[0] > @min_x
      #min x
    end
    if node[0] < @max_x
      #max x
    end
    if node[1] > @min_y
      #min y
    end
    if node][1] < @max_y
    end
  end

  def solve
    start_node = find_start_node
    steps = 0
    solve_inner(start_node, steps)
  end

  def find_start_node
    @nodes.each do |k,v|
      return k if v[:used] == 0
    end
  end

  def find_pairs
    @nodes.sort_by { |pos, values| values[:used]}.each do |node_k, node_v|
      next if node_v[:used] == 0
      @nodes.sort_by { |pos, values| values[:avail]}.each do |match_k, match_v|
        if node_k != match_k # don't match with self
          if node_v[:used] <= match_v[:avail] # find a node with free space
            @number_of_pairs += 1
          end
        end
      end
    end
    puts "available pairs #{@number_of_pairs}"
  end

end

grid_computing = GridComputing.new
grid_computing.load_input
#grid_computing.find_pairs
grid_computing.solve
grid_computing.print
