class RambunctiousRecitation
  def initialize()    
    @input_file   = "input.txt"
    @numbers      = []    
  end

  def get_input
    file = File.new(@input_file, "r")
    @numbers = file.gets.split(",").map(&:to_i)
    file.close
  end

  def solve
    for i in (@numbers.length..2020-1)
      if !@numbers[0..-2].include? @numbers[i-1]
        @numbers << 0
      else        
        @numbers << (i-1) - @numbers[0..-2].rindex(@numbers[i-1])        
      end
    end
    puts @numbers.last
  end
end

program = RambunctiousRecitation.new()
program.get_input
program.solve