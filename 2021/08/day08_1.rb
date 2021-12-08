class SevenSegment
  def initialize()
    @patterns = []    
    self.get_input
  end
  
  def get_input    
    file = File.new("input.txt", "r")
    while (line = file.gets)      
      input = line.split("|")      
      @patterns.push({
        :signals  => input[0].split,
        :displays => input[1].split
      })
    end
    file.close
  end
  
  def solve
    unique_numbers = 0
    @patterns.each do |p|
      unique_numbers += p[:displays].count {|x| [2,3,4,7].include?(x.length)}
    end
    puts unique_numbers
  end
end

program = SevenSegment.new()
program.solve