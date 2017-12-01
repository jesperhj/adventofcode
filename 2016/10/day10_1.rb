#!/bin/ruby

# 0 to low

file = File.new("input.txt", "r")

class BalanceBots
  def initialize
    @inital_instructions = []
    @instructions = []
    @bots = {}
    @outputs = {}
    @bot_we_are_looking_for = 0
  end

  def remove_chip(bot, chip)
    bot = bot.to_i
    chip = chip.to_i
    @bots[bot].delete(chip)
  end

  def give_chip_to_bot(bot, chip)
    bot = bot.to_i
    chip = chip.to_i

    if chip == 17 || chip == 61
      puts "bot #{bot} #{chip}"
    end

    if @bots[bot] == nil
      @bots[bot] = [chip]
    elsif chip > @bots[bot][0]
      @bots[bot].push(chip)
    else
      @bots[bot].insert(0,chip)
    end
  end

  def give_chip_to_output(output, chip)
    output = output.to_i
    chip = chip.to_i

    if @outputs[output] == nil
      @outputs[output] = [chip]
    else
      @outputs[output].push(chip)
    end
  end

  def is_this_the_bot_we_are_looking_for(bot)
    bot = bot.to_i
    if @bots[bot] != nil && @bots[bot].length == 2
      if @bots[bot][0] == 17 && @bots[bot][1] == 61
        @bot_we_are_looking_for = bot
        puts "BOT #{@bot_we_are_looking_for} IS THE ONE"
        exit
      end
    end
  end

  def find_the_bot
    file = File.new("input.txt", "r")
    while (line = file.gets)
      if /^value/.match(line)
        @inital_instructions.push(line)
      else
        @instructions.push(line)
      end
    end
    file.close

    @inital_instructions.each do |todo|
      result = /^value (\d+) goes to bot (\d+)$/.match(todo)
      give_chip_to_bot(result[2], result[1])
    end

    while !@instructions.empty?
      @instructions.each do |todo|
        result = /^bot (\d+).+(bot|output) (\d+).+(bot|output) (\d+)/.match(todo)
        puts result
        bot = result[1]
        low = [result[2], result[3]]
        high = [result[4], result[5]]

        puts "bot #{bot}"

        is_this_the_bot_we_are_looking_for(bot)

        # Only proccess instructions for bots with two chips
        #@bots[bot.to_i][low[1]] != nil && @bots[bot.to_i][high[1]] != nil
        if @bots[bot.to_i] != nil && @bots[bot.to_i].length == 2
          if low[0] == "bot"
            give_chip_to_bot(low[1], @bots[bot.to_i][0])
          else
            give_chip_to_output(low[1], @bots[bot.to_i][0])
          end

          if high[0] == "bot"
            give_chip_to_bot(high[1], @bots[bot.to_i][1])
          else
            give_chip_to_output(high[1], @bots[bot.to_i][1])
          end

          remove_chip(bot, low[1])
          remove_chip(bot, high[1])
          @instructions.delete(todo)
        end
      end
    end
    puts "BOT #{@bot_we_are_looking_for} IS THE ONE"
  end
end

balance_bots = BalanceBots.new
balance_bots.find_the_bot
