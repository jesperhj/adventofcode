#!/bin/ruby

# 66 to low

class Display
  def initialize
    @count = 0
    @screen = {}
    @screen_x = 50
    @screen_y = 6
    init_screen
  end

  def init_screen
    (0..@screen_y-1).each do |i|
      @screen[i] = create_row
    end
  end

  def count_pixels
    @count = 0
    (0..@screen_y-1).each do |i|
      (0..@screen_x-1).each { |j| @count += @screen[i][j] }
    end
    return @count
  end

  def fill_rec(x,y)
    (0..y-1).each do |i|
      puts "FILL #{x}x#{y}"
      (0..x-1).each { |j| @screen[i][j] = 1}
    end
  end

  def create_row
    row = []
    (0..@screen_x-1).each { row << 0 }
    return row
  end

  def rotate_rec(axis, line, movement)
    puts "rotating #{axis} #{line} by #{movement}"
    if axis == "row"
      (0..movement-1).each do |move|
        (@screen_x-1).downto(0).to_a.each do |i|
          @screen[line][i+1] = @screen[line][i]
        end
        @screen[line][0] = @screen[line][@screen_x]
        @screen[line].delete_at(@screen_x)
      end
    else
      (0..movement-1).each do |move|
        (@screen_y-1).downto(0).to_a.each do |i|
          if @screen[i+1] == nil
            @screen[i+1] = create_row
          end
          @screen[i+1][line] = @screen[i][line]
        end
        @screen[0][line] = @screen[@screen_y][line]
        @screen.delete(@screen_y)
      end
    end
  end

  def solve
    file = File.new("input.txt", "r")
    while (line = file.gets)
      fill   = /rect (\d+)x(\d+)/.match(line)
      rotate = /rotate (column|row) (x|y)=(\d+) by (\d+)/.match(line)
      if fill != nil
        fill_rec(fill[1].to_i, fill[2].to_i)
      else
        rotate_rec(rotate[1], rotate[3].to_i, rotate[4].to_i)
      end
      @screen.each {|k,v| puts "#{v}"}
    puts "--"
    end
    file.close
    @screen.each {|k,v| puts "#{v}"}
    puts "#{count_pixels} pixels are lit"
  end

end

display = Display.new
display.solve
