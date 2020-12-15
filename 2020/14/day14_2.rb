class DockingData
  def initialize()    
    @input_file   = "input.txt"
    @mask         = ""
    @memory       = {}
    @lines        = []
  end

  def get_input
    file = File.new(@input_file, "r")
    i = 0
    while (line = file.gets)
      @lines << line
    end    
    file.close
  end

  def solve
    @lines.each do |line|
      if line.scan(/^mask/)[0]
        @mask = line.scan(/^mask = (.*)/)[0][0]
        next
      end
      instruction = line.scan(/mem\[(\d+)\] = (\d+)/)[0]
      address     = instruction[0].to_i.to_s(2).rjust(36, '0')
      value       = instruction[1].to_i

      # for 0 do nothing
      # for 1 copy 1
      # for x create a new address and store a version with 0 and 1
      addresses = [address]
      for i in 0..@mask.length-1
        if @mask[i] == "0"
          next
        elsif @mask[i] == "1"
          for j in 0..addresses.length-1            
             addresses[j][i] = "1"
          end
        else
          for j in 0..addresses.length-1
            address2          = addresses[j].clone
            addresses[j][i]  = "0"
            address2[i]       = "1"
            addresses.push(address2)            
          end
        end
      end

      # go over all addresses and set the value in memory
      addresses.each do |a|
        @memory[a.to_i(base=2)] = value
      end

    end

    sum = 0
    @memory.each do |k,v|
      sum += v
    end    
    puts sum
  end
end

program = DockingData.new()
program.get_input
program.solve