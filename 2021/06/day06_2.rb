class Lanternfish
  def initialize()
    @lanterns = [0,0,0,0,0,0,0,0,0]
    @days     = 256
    self.get_input    
  end
  
  def get_input    
    file = File.new("input.txt", "r")
    file.gets.split(",").each do |l|
      @lanterns[l.to_i] += 1
    end
    file.close
  end
  
  def solve  
    (0..@days-1).each do |d|
      new_lanterns = @lanterns.shift      
      @lanterns[6] += new_lanterns
      @lanterns.push(new_lanterns)
    end
        
    puts @lanterns.sum
  end
end

program = Lanternfish.new()
program.solve