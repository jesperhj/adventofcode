class RainRisk
  def initialize()    
    @input_file = "input.txt"
    @actions    = []
    @position   = {:x =>  0, :y => 0}
    @waypoint   = {:x => 10, :y => 1}
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

  def move(move)    
    (1..move).each do
      @position[:x] += @waypoint[:x]
      @position[:y] += @waypoint[:y]
    end
  end

  def move_waypoint(dir, move)
    case dir
    when "N"
      @waypoint[:y] += move
    when "S"
      @waypoint[:y] -= move
    when "E"
      @waypoint[:x] += move
    when "W"
      @waypoint[:x] -= move
    end
  end

  def rotate_waypoint(new_direction)
    rad   = new_direction*Math::PI/180 # convert to radians for sin and cos
    new_x = @waypoint[:x] * Math.cos(rad) - @waypoint[:y] * Math.sin(rad)
    new_y = @waypoint[:y] * Math.cos(rad) + @waypoint[:x] * Math.sin(rad)
    @waypoint[:x] = new_x.round
    @waypoint[:y] = new_y.round
  end

  def solve
    @actions.each do |action|
      if ["N","S","E","W"].include? action[:dir]
        move_waypoint(action[:dir], action[:move])
      elsif action[:dir] == "F"
        move(action[:move])
      elsif action[:dir] == "L"
        new_direction = (@degrees[@direction] + action[:move]) % 360
        rotate_waypoint(new_direction)
      elsif action[:dir] == "R"
        new_direction = (@degrees[@direction] - action[:move]) % 360
        rotate_waypoint(new_direction)
      end
    end
    puts "#{@position} = #{@position[:x].abs+@position[:y].abs}"    
  end

end

rain_risk = RainRisk.new()
rain_risk.get_input
rain_risk.solve

