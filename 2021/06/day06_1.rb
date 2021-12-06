class Lanternfish
  def initialize()
    @lanterns = []    

    self.get_input    
  end
  
  def get_input    
    file = File.new("input_test.txt", "r")
    @lanterns = file.gets.split(",").map {|x| x.to_i}
    file.close    
  end
  
  def solve    
  end
end

program = Lanternfish.new()
program.solve