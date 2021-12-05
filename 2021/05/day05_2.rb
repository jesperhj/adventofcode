class HydrothermalVenture
  def initialize()
    @diagram = nil
    @vents   = []
    @max_x   = 0
    @max_y   = 0

    self.get_input
    self.init_diagram
  end
  
  def get_input
    # Read input and store coordinates for vents
    file = File.new("input.txt", "r")
    while (line = file.gets)
      res = line.scan(/(\d+),(\d+) -> (\d+),(\d+)/)[0]
      v = {
        :x1 => res[0].to_i,
        :y1 => res[1].to_i,
        :x2 => res[2].to_i,
        :y2 => res[3].to_i
      }
      self.set_diagram_max_values(v)
      @vents.push(v)
    end
    file.close
  end

  def set_diagram_max_values(v)
    @max_x = v[:x1] if v[:x1] > @max_x
    @max_x = v[:x2] if v[:x2] > @max_x
    @max_y = v[:y1] if v[:y1] > @max_y
    @max_y = v[:y2] if v[:y2] > @max_y
  end

  # Init diagram max_x x max_y with 0 as default
  def init_diagram
    max = @max_x > @max_y ? @max_x : @max_y    
    @diagram = []
    (0..max).each do
      @diagram.push(Array.new(max+1, 0))    
    end    
  end

  def solve
    @vents.each do |v|
      if v[:x1] == v[:x2]
        start, stop = v[:y1] < v[:y2] ? [v[:y1],v[:y2]] : [v[:y2],v[:y1]]
        for i in start..stop
          @diagram[i][v[:x1]] += 1
        end
      elsif v[:y1] == v[:y2]        
        start, stop = v[:x1] < v[:x2] ? [v[:x1],v[:x2]] : [v[:x2],v[:x1]]
        for i in start..stop
          @diagram[v[:y1]][i] += 1
        end
      else
        delta = v[:x1] > v[:x2] ? v[:x1]-v[:x2] : v[:x2]-v[:x1]        
        for i in 0..delta
          x = v[:x1] < v[:x2] ? 1 : -1
          y = v[:y1] < v[:y2] ? 1 : -1          
          @diagram[v[:y1]+i*y][v[:x1]+i*x] += 1
        end        
      end
    end
  
    res = @diagram.flatten.count {|x| x > 1}
    puts res
  end
end

program = HydrothermalVenture.new()
program.solve