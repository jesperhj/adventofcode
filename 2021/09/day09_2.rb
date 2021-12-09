# 599256 too low
class SmokeBasin
  def initialize()
    @tubes      = []
    @low_points = []
    @basins     = []
    self.get_input
  end

  def get_input
    file = File.new("input.txt", "r")
    while (line = file.gets)
      @tubes.push line.strip.split("").map! {|x| x.to_i}
    end
    file.close
  end

  def calculate_basin(i,j,nr,tracked)
    return nr if @tubes[i][j] == 9 || tracked.include?(i.to_s+":"+j.to_s)
    puts "#{i}:#{j}-#{@tubes[i][j]} ##{nr}"
    nr += 1
    tracked.push i.to_s+":"+j.to_s
    if i > 0 && @tubes[i][j]+1 == @tubes[i-1][j]
      nr = self.calculate_basin(i-1,j,nr,tracked)
    end
    if i < @tubes.length-1 && @tubes[i][j]+1 == @tubes[i+1][j]
      nr = self.calculate_basin(i+1,j,nr,tracked)
    end
    if j > 0 && @tubes[i][j]+1 == @tubes[i][j-1]
      nr = self.calculate_basin(i,j-1,nr,tracked)
    end
    if j < @tubes[i].length-1 && @tubes[i][j]+1 == @tubes[i][j+1]
      nr = self.calculate_basin(i,j+1,nr,tracked)
    end
    return nr
  end

  def solve
    for i in 0..@tubes.length-1
      for j in 0..@tubes[i].length-1
        is_low = true
        is_low = false if i > 0 && @tubes[i][j] >= @tubes[i-1][j]
        is_low = false if i < @tubes.length-1 && @tubes[i][j] >= @tubes[i+1][j]
        is_low = false if j > 0 && @tubes[i][j] >= @tubes[i][j-1]
        is_low = false if j < @tubes[i].length-1 && @tubes[i][j] >= @tubes[i][j+1]
        if is_low
          @low_points.push @tubes[i][j]
          @basins.push self.calculate_basin(i,j,0,[])
          puts ""
        end
      end
    end
    puts @basins.join(",")
    puts @basins.sort.join("-")
    puts @basins.sort.last(3).inject(:*)
    puts "#{@low_points.length} : #{@basins.length}"
  end
end

program = SmokeBasin.new()
program.solve
