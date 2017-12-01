#!/bin/ruby

# 1049 to high
# 1 to low

class GridComputing
  def initialize
    @nodes = {}
    @number_of_pairs = 0
  end

  def load_input
    file = File.new("input.txt", "r")
      while (line = file.gets)
      next unless line[0] == "/"
      input = /^\/dev\/grid\/node-x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T\s*(\d+)T\s*(\d+)%/.match(line)
      @nodes[[input[1],input[2]]] = {
        :size   => input[3].to_i,
        :used   => input[4].to_i,
        :avail  => input[5].to_i,
        :use    => input[6].to_i
      }
      end
    file.close
  end

  def print
    file = File.new("avail.txt", "w")
    @nodes.sort_by { |pos, values| values[:avail]}.each do |node_k, node_v|
      file.write("#{node_k} #{node_v}\n")
    end
    file.close
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
grid_computing.find_pairs
#grid_computing.print
