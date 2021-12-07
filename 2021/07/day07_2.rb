class Crabs
  def initialize()
    @crabs = []    
    self.get_input
  end
  
  def get_input    
    file = File.new("input.txt", "r")
    @crabs = file.gets.split(",").map {|x| x.to_i}
    file.close    
  end
  
  def solve
    min_fuel = nil
    (@crabs.min..@crabs.max).each do |i|
      fuel = 0
      @crabs.each do |crab|
        steps = crab > i ? crab - i : i - crab
        fuel += (0..steps).sum
      end
      min_fuel = fuel if min_fuel.nil? || fuel < min_fuel 
    end
    puts min_fuel
  end
end

program = Crabs.new()
program.solve