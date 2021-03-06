class IntcodeComputer
   def initialize
    @instructions = []
    @intcode = []
  end

  def get_input
    file = File.new("input.txt", "r")
    while (line = file.gets)
      @instructions = line.split(',')
    end
    file.close
    @instructions = @instructions.map(&:to_i)
  end

  def print_intcode
    res = ""
    @instructions.each do |x|
      res += "#{x},"
    end
    puts res    
  end

  def set_positions(oc, modes)
    modes[:p1] = :position
    modes[:p2] = :position
    modes[:p3] = :position

    modes[:p3] = :immediate if(oc / 10000) == 1
    oc = oc % 10000
    modes[:p2] = :immediate if(oc / 1000) == 1
    oc = oc % 1000
    modes[:p1] = :immediate if(oc / 100) == 1
    modes[:oc] = oc % 100
  end

  def get_position(modes, intcode, value, position)
    #puts "get_position : #{modes}, #{intcode}, #{value} #{position} - #{modes[value]}"
    res = position
    if(modes[value] == :immediate)
      case value
      when :p1
        res += 1
      when :p2
        res += 2
      when :p3
        res += 3
      end
    else
      case value
      when :p1
        res = intcode[position+1]
      when :p2
        res = intcode[position+2]
      when :p3
        res = intcode[position+3]
      end
    end
    #puts "position : #{position}, value :#{value}, res: #{res} v : #{intcode[res]}"
    return res
  end

  def run(noun: nil, verb: nil, to_store: nil, input_1: nil, input_2: nil, phase_input: nil?)
    intcode    = @instructions
    intcode[0] = input_1 unless input_1.nil?
    intcode[1] = input_2 unless input_2.nil?
    intcode[1] = noun unless noun.nil?
    intcode[2] = verb unless verb.nil?
    position   = 0
    modes      = {
      :oc => nil,
      :p1 => :position,
      :p2 => :position,
      :p3 => :position
    } 

    while !intcode[position].nil? && intcode[position] != 99 do
      set_positions(intcode[position], modes)
      #puts "#{modes}, #{intcode}, :p1, #{position}"

      p1 = get_position(modes, intcode, :p1, position)
      p2 = get_position(modes, intcode, :p2, position)
      p3 = get_position(modes, intcode, :p3, position)

      if(modes[:oc] == 1)
        intcode[p3] = intcode[p1] + intcode[p2]
        position += 4
      elsif(modes[:oc] == 2)    
        intcode[p3] = intcode[p1] * intcode[p2]
        position += 4
      elsif(modes[:oc] == 3)            
        intcode[p1] = phase_input.shift
        position += 2     
      elsif(modes[:oc] == 4)      
        #puts intcode[p1]
        return intcode[p1]
        position += 2
      elsif(modes[:oc] == 5)  
        position = (intcode[p1] != 0) ? intcode[p2] : position + 3
      elsif(modes[:oc] == 6)
        position = (intcode[p1] == 0) ? intcode[p2] : position + 3
      elsif(modes[:oc] == 7)
        intcode[p3] = (intcode[p1] < intcode[p2]) ? 1 : 0
        position += 4
      elsif(modes[:oc] == 8)
        intcode[p3] = (intcode[p1] == intcode[p2]) ? 1 : 0
        position += 4
      else
        puts "error at position #{position}"
        break
      end
    end
    print_intcode
    return intcode[0]
  end

end

input = [0,1,2,3,4]
highest_output = 0
input.permutation.each do |p|
  input_2 = 0
  p.each do |i|
    #puts "interation #{i}"
    icc = IntcodeComputer.new  
    icc.get_input
    #icc.print_intcode
    input_2 = icc.run(phase_input: [i, input_2])
    #icc.print_intcode        
  end
  highest_output = input_2 if input_2 > highest_output
end
puts highest_output