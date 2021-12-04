class BingoCard
  def initialize()    
    @lines         = []
    @drawn_numbers = []
  end

  def add_line(line)
    @lines.push(line.split.to_a)
  end

  def check_for_bingo(drawn_number)
    @drawn_numbers.push(drawn_number)

    return true if self.check_rows()
    return true if self.check_columns()
    return false
  end

  def check_columns
    for i in 0..4
      found_columns = 0
      @lines.each do |l|
        found_columns += 1 if @drawn_numbers.include?(l[i])
      end
      return true if found_columns == 5
    end
    return false
  end

  def check_rows
    @lines.each do |l|
      return true if (l-@drawn_numbers).empty?
    end
    return false
  end

  def get_sum_of_unmarked_numbers
    return (@lines.flatten-@drawn_numbers).sum {|i| i.to_i}
  end

  def print
    @lines.each do |s|
      puts s.join(" ")
    end
  end

end

class BingoSubystem
  def initialize()    
    @input_file    = "input.txt"
    @balls         = []
    @cards         = []
    @drawn_numbers = []
  end

  def get_input
    file = File.new(@input_file, "r")
    i = 0
    # get bingo balls aka the numbers
    line = file.gets
    @balls = line.split(",")

    # get bingo cards
    while (line = file.gets)
      next if line.length == 1
      card = BingoCard.new() if i % 5 == 0
      card.add_line(line)
      @cards.push(card) if i % 5 == 4
      i += 1
    end    
    file.close
  end

  def draw_number
    @drawn_numbers.push(@balls.shift)
  end

  def play
    while !@balls.empty?
      self.draw_number()

      @cards.each do |c|
        if c.check_for_bingo(@drawn_numbers.last)
          res = c.get_sum_of_unmarked_numbers * @drawn_numbers.last.to_i
          puts res
          return
        end
      end
    end
  end
end

program = BingoSubystem.new()
program.get_input
program.play