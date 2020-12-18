class OperationOrder
  def initialize()    
    @input_file     = "input_test.txt"
    @expression     = ""
    @result         = nil
    @next_operation = nil
  end

  def get_input
    file    = File.new(@input_file, "r")
    @expression  = file.gets
    file.close
  end

  def solve
    puts @expression
    @expression.split.each do |i|
      if i == "+"
        @next_operation = "+"
      elsif i == "*"
        @next_operation = "*"
      elsif i == "("
      elsif i == ")"
      elsif !["+","*"].include? i
        if @result.nil? # first
          @result = i.to_i
        else #if !@next_operation.nil?
          case @next_operation
          when "+"
            @result += i.to_i
          when "*"
            @result *= i.to_i
          end
        end
      end
    end

    puts @result
  end
end

program = OperationOrder.new()
program.get_input
program.solve