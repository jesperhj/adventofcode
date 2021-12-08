class SevenSegment
  def initialize()
    @patterns = []    
    self.get_input
  end
  
  def get_input    
    file = File.new("input.txt", "r")
    while (line = file.gets)      
      input = line.split("|")      
      @patterns.push({
        :signals  => input[0].split,
        :displays => input[1].split,
        :mapped => [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
      })
    end
    file.close
  end
  
  def map_wires(pattern)    
    # map 1,4,7,8
    pattern[:signals].each do |p|
      pattern[:mapped][1] = p if p.length == 2
      pattern[:mapped][4] = p if p.length == 4
      pattern[:mapped][7] = p if p.length == 3          
      pattern[:mapped][8] = p if p.length == 7
    end    

    # map a,d,g
    ttf = pattern[:signals].select{|x| x if x.length == 5}
    adg = ttf[0].split("") & ttf[1].split("") & ttf[2].split("") 
    adgcf = adg+pattern[:mapped][1].split("")
    
    pattern[:signals].each do |x|
      # map 9
      if x.length == 6 && (x.split("")-adgcf).length == 1
        pattern[:mapped][9] = x
      # map 0
      elsif x.length == 6 && (x.split("")-adg).length == 4
        pattern[:mapped][0] = x
      # map 6
      elsif x.length == 6
        pattern[:mapped][6] = x
      end
    end

    # map 3
    pattern[:signals].each do |x|          
      if x.length == 5 && (x.split("")-adgcf).length == 0
        pattern[:mapped][3] = x
      elsif x.length == 5 && (pattern[:mapped][6].split("")-x.split("")).length == 1
        pattern[:mapped][5] = x
      elsif x.length == 5
         pattern[:mapped][2] = x
      end            
    end
    # sort to allow for easier compare
    pattern[:mapped].map! {|x| x.split("").sort.join()}    
  end

  def solve
    res = 0
    @patterns.each do |p|
      # map all numbers
      self.map_wires(p)
      digits = ""
      # get value of the displayed numbers
      p[:displays].each do |d|
        d = d.split("").sort().join
        digits += p[:mapped].index(d).to_s
      end
      res += digits.to_i
    end
    puts res
  end
end

program = SevenSegment.new()
program.solve