class RainRisk
  def initialize()    
    @input_file = "input.txt"
    @actions    = []
    @position   = {:x => 0, :y => 0}
    @direction  = "E"
    @degrees    = {"E" => 0, "N" => 90, "W" => 180, "S" => 270}
  end

  def get_input
    file = File.new(@input_file, "r")
    while (line = file.gets)
      line.strip!
      @actions.push({
        :dir => line[0],
        :move => line[1..-1].to_i
      })
    end
    file.close    
  end

  def move(dir, move)
    case dir
    when "N"
      @position[:y] += move
    when "S"
      @position[:y] -= move
    when "E"
      @position[:x] += move
    when "W"
      @position[:x] -= move
    end
  end

  def solve
    @actions.each do |action|
      if ["N","S","E","W"].include? action[:dir]
        move(action[:dir], action[:move])
      elsif action[:dir] == "F"
        move(@direction, action[:move])
      elsif action[:dir] == "L"
        new_direction = (@degrees[@direction] + action[:move]) % 360
        @direction = @degrees.key(new_direction)
      elsif action[:dir] == "R"
        new_direction = (@degrees[@direction] - action[:move]) % 360
        @direction = @degrees.key(new_direction)
      end
    end
    puts "#{@position} = #{@position[:x].abs+@position[:y].abs}"    
  end

end

rain_risk = RainRisk.new()
rain_risk.get_input
rain_risk.solve

