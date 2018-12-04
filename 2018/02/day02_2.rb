#!/bin/ruby

file = File.new("input.txt", "r")
lines = []
while (line = file.gets)
  lines << line.strip
end
file.close

i = 0
#go over all lines
lines.each do |line|

  # compare it to all others lines
  lines.each do |l|
    diff = 0
    j = 0
    # count diffs in strings
    l.split("").each do
      if line[j] != l[j]
        diff = diff+1
      end
      j = j+1
    end

    # if diff is 1 we have a winner
    if diff == 1
      res = ""
      j = 0
      # ugly way of getting result
      l.split("").each do
        if line[j] == l[j]
          res << l[j]
        end
        j = j+1
      end

      puts "Result #{res}"
      exit
    end
  end
  i = i+1
end


