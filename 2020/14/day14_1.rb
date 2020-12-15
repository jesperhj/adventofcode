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
      address     = instruction[0].to_i
      value       = instruction[1].to_i.to_s(2).rjust(36, '0')

      for i in 0..@mask.length-1
        value[i] = @mask[i] if @mask[i] != "X"
      end
      @memory[address] = value
    end
    
    sum = 0
    @memory.each do |k,v|
      sum += v.to_i(base=2)
    end    
    puts sum
  end
end

program = DockingData.new()
program.get_input
program.solve