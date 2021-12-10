class SyntaxScoring
  def initialize()
    @lines = []
    @corrupt_lines = []
    @open = ["(", "[", "{", "<"]
    @close = [")", "]", "}", ">"]
    @discard_scores = []
    @incomplete_score = []
    @discard_score_table = {
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137
    }
    @incomplete_score_table = {
      "(" => 1,
      "[" => 2,
      "{" => 3,
      "<" => 4
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
    score = 0
    line.split("").each do |l|
      if stack.empty? || @open.include?(l)
        stack.push(l)
      elsif @close.index(l) == @open.index(stack.last)
        stack.pop
      else
        @corrupt_lines.push(line)
        @discard_scores.push(@discard_score_table[l])
        return false
      end
    end    
    if stack.empty? == false
      stack.reverse.each do |s|        
        score = score*5 + @incomplete_score_table[s]
      end
      @incomplete_score.push(score)
    end
    return true
  end

  def solve    
    @lines.each do |line|
      handle_line(line)
    end    
    puts @incomplete_score.sort[@incomplete_score.length/2]
  end
end

program = SyntaxScoring.new()
program.solve
