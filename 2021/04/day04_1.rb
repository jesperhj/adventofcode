class BingoCard
  def initialize()    
    @squares = []    
  end

  def add_line(line)
    @squares.push(line.split.to_a)
  end

  def print
    @squares.each do |s|
      puts s.join(" ")
    end
  end
end

class BingoSubystem
  def initialize()    
    @input_file = "input_test.txt"
    @balls      = []
    @cards      = []    
  end

  def get_input
    file = File.new(@input_file, "r")
    i = 0
    # get bingo balls aka the numbers
    line = file.gets
    @bingo_balls = line.split(",")

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

  def play
    @cards.each do |c|
      c.print()
      puts "-"
    end
  end
end

program = BingoSubystem.new()
program.get_input
program.play