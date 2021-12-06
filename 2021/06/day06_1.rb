class Lanternfish
  def initialize()
    @lanterns = []    
    @days     = 80
    self.get_input    
  end
  
  def get_input    
    file = File.new("input.txt", "r")
    @lanterns = file.gets.split(",").map {|x| x.to_i}
    file.close    
  end
  
  def solve   
    (0..@days-1).each do |d|
      new_lanterns = []
      for i in 0..@lanterns.length-1
        if @lanterns[i] == 0
          @lanterns[i] = 6
          new_lanterns.push(8)
        else
          @lanterns[i] -= 1
        end
      end

      @lanterns = @lanterns.concat(new_lanterns)
    end    
    
    puts @lanterns.count
  end
end

program = Lanternfish.new()
program.solve