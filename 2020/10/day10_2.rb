class AdapterArray
  def initialize()    
    @input_file = "input.txt"
    @adapters = [0]
    @c = {}
  end

  def get_input
    file = File.new(@input_file, "r")
    while (line = file.gets)  
      @adapters.push(line.to_i)
    end
    file.close
    @adapters.sort!
  end

  def find_arrangements(pos, paths)
    # Return if we hit the end or have things cached
    return @c[pos] if @c.keys.include? pos   
    return 1       if pos >= @adapters.length-1

    # Continue down the paths if we are not going out of bound
    (pos+1..pos+3).each do |j|      
      if j <= @adapters.length-1 && (@adapters[j] - @adapters[pos] <= 3)    
        paths += find_arrangements(j, paths)
      end
    end

    @c[pos] = paths # cache result

    return paths
  end
end

aa = AdapterArray.new()
aa.get_input
puts aa.find_arrangements(0, 0)
