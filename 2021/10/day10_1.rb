class SyntaxScoring
  def initialize()
    @lines = []
    @corrupt_lines = []
    @open = ["(", "[", "{", "<"]
    @close = [")", "]", "}", ">"]
    @scores = []
    @score_table = {
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137
    }
    self.get_input
  end

  def get_input
    file = File.new("input.txt", "r")
    while (line = file.gets)
      @lines.push line.strip
    end
    file.close
  end

  def handle_line(line)
    stack = []
    line.split("").each do |l|
      if stack.empty? || @open.include?(l)
        stack.push(l)
      elsif @close.index(l) == @open.index(stack.last)
        stack.pop 
      else
        @corrupt_lines.push(line)
        @scores.push(@score_table[l])
        return false
      end
    end
    return true
  end

  def solve    
    @lines.each do |line|    
      handle_line(line)
    end    
    puts @scores.sum
  end
end

program = SyntaxScoring.new()
program.solve
