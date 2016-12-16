#!/bin/ruby

class RTG
  def initialize
    @input_file = "input_test.txt"
    @floor_map = {"first"=>1, "second"=>2, "third"=>3, "fourth"=>4}
    @floors = {
      1 => { "generator" => [], "microchip" => [] },
      2 => { "generator" => [], "microchip" => [] },
      3 => { "generator" => [], "microchip" => [] },
      4 => { "generator" => [], "microchip" => [] }
    }
    @elevator = 1
  end

  def finished?
    @floors[1]["generator"].empty? && @floors[1]["microchip"].empty? &&
    @floors[2]["generator"].empty? && @floors[2]["microchip"].empty? &&
    @floors[3]["generator"].empty? && @floors[3]["microchip"].empty?
  end

  def get_input
    file = File.new(@input_file, "r")
    while (line = file.gets)
      res = /The (\w+) floor contains (.*)/.match(line)
      floor = @floor_map[res[1]]
      if !/^nothing.*/.match(res[2])
        res[2].split("a ").each do |item|
          next if item.empty?
          item = /(\w+)(-compatible)?\s(\w+)/.match(item.chomp().chomp(", and ").chomp(", ").chomp("."))
          @floors[floor][item[3]].push(item[1])
        end
      end
    end
    file.close
  end

  def solve
    get_input
    puts "#{@floors}"

    #while !finished?
    #end

  end
end

rtg = RTG.new
rtg.solve
