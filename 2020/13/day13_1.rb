class ShuttleSearch
  def initialize()    
    @input_file         = "input.txt"
    @buses              = []
    @earliest_departure = 0
    @departure          = {:bus => 0, :time => nil}
  end

  def get_input
    file = File.new(@input_file, "r")
    @earliest_departure = file.gets.to_i
    @buses              = file.gets.scan(/\d+/).map(&:to_i)
    file.close
  end

  def solve
    @buses.each do |bus|
      tmp = @earliest_departure / bus 
      bus_departure = tmp * bus + (bus % @earliest_departure)

      if @departure[:time].nil? || bus_departure < @departure[:time]
        @departure[:bus]  = bus
        @departure[:time] = bus_departure
      end
    end
    puts @departure
    puts @departure[:bus]*(@departure[:time]-@earliest_departure)
  end  
end

shuttle_search = ShuttleSearch.new()
shuttle_search.get_input
shuttle_search.solve