class SeatingSystem
  def initialize()    
    @input_file = "input.txt"
    @map = []
    @nr_of_occupied_seats = 0
  end

  def get_input
    file = File.new(@input_file, "r")
    while (line = file.gets)  
      @map.push(line)
    end
    file.close    
  end

  def get_nr_of_occupied_seats
    return @nr_of_occupied_seats
  end

  # If a seat is empty (L) and there are no
  # occupied seats adjacent to it, the seat becomes occupied
  def no_occupied_seats_adjacent(i, j)    
    ret = true

    if (j != 0 && @map[i][j-1] == "#") ||                           #left
       (i != 0 && j != 0 && @map[i-1][j-1] == "#") ||               #upper left
       (i != 0 && @map[i-1][j] == "#") ||                           #upp
       (i != 0 && j < @map[i].length-1 && @map[i-1][j+1] == "#") || #upper right
       (j < @map[i].length - 1 && @map[i][j+1] == "#") ||           #right
       (i < @map[i].length - 1 && j < @map[i].length-1 && @map[i+1][j+1] == "#") || #lower right
       (i < @map[i].length - 1 && @map[i+1][j] == "#") ||           #down
       (i < @map[i].length - 1 && j != 0 && @map[i+1][j-1] == "#")  #lower left      
      ret = false
    end
    return ret
  end

  # If a seat is occupied (#) and four or more seats adjacent 
  # to it are also occupied, the seat becomes empty.
  def too_many_occupied_seats_adjacent(i, j)
    occupied_seats = 0
    if (j != 0 && @map[i][j-1] == "#") #left
      occupied_seats += 1
    end
    if (i != 0 && j != 0 && @map[i-1][j-1] == "#") #upper left
      occupied_seats += 1
    end
    if (i != 0 && @map[i-1][j] == "#") #upp
      occupied_seats += 1
    end
    if (i != 0 && j < @map[i].length-1 && @map[i-1][j+1] == "#") #upper right
      occupied_seats += 1
    end
    if (j < @map[i].length - 1 && @map[i][j+1] == "#") #right
      occupied_seats += 1
    end
    if (i < @map[i].length - 1 && j < @map[i].length-1 && 
        @map[i+1][j+1] == "#") #lower right
      occupied_seats += 1
    end
    if (i < @map[i].length - 1 && @map[i+1][j] == "#") #down
      occupied_seats += 1
    end
    if (i < @map[i].length - 1 && j != 0 && @map[i+1][j-1] == "#") #lower left
      occupied_seats += 1
    end

    return occupied_seats >= 4
  end

  def seatings_changed?(new_map)
    for i in 0..@map.length-1
      for j in 0..@map.length-1
        #puts "#{@map[i][j]} = #{new_map[i][j]}"
        if @map[i][j] != new_map[i][j]
          return true 
        end
      end
    end 
    return false
  end

  def apply_rules_with_change
    ret = false
    new_map = Marshal.load(Marshal.dump(@map))

    for i in 0..@map.length-1
      for j in 0..@map.length-1        
        next if @map[i][j] == "."

        if @map[i][j] == "L" && no_occupied_seats_adjacent(i, j)
          new_map[i][j] = "#"
        elsif @map[i][j] == "#" && too_many_occupied_seats_adjacent(i, j)
          new_map[i][j] = "L"
        end
      end
    end

    ret = true if seatings_changed?(new_map)      
    @map = new_map
    return ret

  end

  def count_nr_of_occupied_seats
    @nr_of_occupied_seats = 0

    for i in 0..@map.length-1
      for j in 0..@map.length-1        
        @nr_of_occupied_seats +=1 if @map[i][j] == "#"    
      end
    end
  end

  def find_nr_of_seats
    while true
      res = apply_rules_with_change()
      break if !res
    end

    count_nr_of_occupied_seats
  end
end

seating_system = SeatingSystem.new()
seating_system.get_input
seating_system.find_nr_of_seats
puts seating_system.get_nr_of_occupied_seats
