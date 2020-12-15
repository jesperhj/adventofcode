class RambunctiousRecitation
  def initialize()    
    @input_file   = "input.txt"
    @numbers      = {}
    @last         = nil
  end

  def get_input
    file = File.new(@input_file, "r")
    i = 0
    file.gets.split(",").map(&:to_i).each do |n|
      @numbers[n] = {:pos => i, :prev_pos => nil}
      @last = n      
      i += 1
    end
    file.close
  end

  def solve    
    for i in (@numbers.length..30000000-1)
      if @numbers[@last][:prev_pos].nil?
        @last       = 0
        prev_pos    = @numbers[0].nil? ? nil : @numbers[0][:pos]
        @numbers[0] = {:pos => i, :prev_pos => prev_pos}
      else
        @last           = @numbers[@last][:pos]-@numbers[@last][:prev_pos]
        prev_pos        = @numbers[@last].nil? ? nil : @numbers[@last][:pos]
        @numbers[@last] = {:pos => i, :prev_pos => prev_pos}
      end      
    end

    puts @last
  end
end

program = RambunctiousRecitation.new()
program.get_input
program.solve