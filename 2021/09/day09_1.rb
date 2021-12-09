class SmokeBasin
  def initialize()
    @tubes      = []
    @low_points = []
    self.get_input
  end

  def get_input
    file = File.new("input.txt", "r")
    while (line = file.gets)
      @tubes.push line.strip.split("").map! {|x| x.to_i}
    end
    file.close
  end

  def solve
    for i in 0..@tubes.length-1
      for j in 0..@tubes[i].length-1
        is_low = true
        is_low = false if i > 0 && @tubes[i][j] >= @tubes[i-1][j]
        is_low = false if i < @tubes.length-1 && @tubes[i][j] >= @tubes[i+1][j]
        is_low = false if j > 0 && @tubes[i][j] >= @tubes[i][j-1]
        is_low = false if j < @tubes[i].length-1 && @tubes[i][j] >= @tubes[i][j+1]        
        @low_points.push @tubes[i][j] if is_low
      end
    end    
    puts @low_points.sum {|x|x+1}
  end
end

program = SmokeBasin.new()
program.solve
