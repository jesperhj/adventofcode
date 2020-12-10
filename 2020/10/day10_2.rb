class AdapterArray

  def initialize()    
    @input_file = "input.txt"
    @adapters = []
    @c = {}
  end

  def get_input
    file = File.new(@input_file, "r")
    while (line = file.gets)  
      @adapters.push(line.to_i)
    end
    file.close
    @adapters << 0
    @adapters.sort!
  end

  def find_arrangements(i, paths)
      
    if i >= @adapters.length-1
      return 1
    end
    if i+1 <= @adapters.length-1 && (@adapters[i+1] - @adapters[i] <= 3)      
      paths = find_arrangements(i+1, paths) 
    end
    if i+2 <= @adapters.length-1 && (@adapters[i+2] - @adapters[i] <= 3)
      if @c.keys.include? @adapters[i+2]
        paths += @c[@adapters[i+2]]
      else
        paths += find_arrangements(i+2, paths)
      end
    end
    if i+3 <= @adapters.length-1 && (@adapters[i+3] - @adapters[i] <= 3)
       if @c.keys.include? @adapters[i+3]
        paths += @c[@adapters[i+3]]        
      else
        paths += find_arrangements(i+3, paths)
      end
    end

    @c[@adapters[i]] = paths
    return paths
  end
end

aa = AdapterArray.new()
aa.get_input
arr = aa.find_arrangements(0, 0)

puts arr
