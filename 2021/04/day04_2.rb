class BingoCard
  def initialize()    
    @lines         = []
    @drawn_numbers = []
    @active        = true
  end

  def inactivate
    @active = false
  end

  def is_active?
    return @active
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
        if @drawn_numbers.include?(l[i])
          found_columns += 1
        end
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
    @active_cards  = 0
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
      if i % 5 == 4
        @cards.push(card)  
        @active_cards += 1
      end
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
        if c.is_active? && c.check_for_bingo(@drawn_numbers.last)      
          if @active_cards == 1 # we have a winner
            res = c.get_sum_of_unmarked_numbers * @drawn_numbers.last.to_i
            puts res
            return
          else
            c.inactivate
            @active_cards -= 1
          end
        end
      end

    end
  end
end

program = BingoSubystem.new()
program.get_input
program.play