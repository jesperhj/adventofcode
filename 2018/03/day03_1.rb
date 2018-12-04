#!/bin/ruby
result = 0
fabric = {}

file = File.new("input2.txt", "r")
while (line = file.gets)
  res = /#\d*\s@\s(\d*),(\d*):\s(\d*)x(\d*)/.match(line)
  coordinates = [res[1].to_i,res[2].to_i]
  size = [res[3].to_i,res[4].to_i]

  (coordinates[0]..coordinates[0]+size[0]-1).each do |i|
    (coordinates[1]..coordinates[1]+size[1]-1).each do |j|
      # to lazy to install tuple gem :)
      fabric["(#{i},#{j})"] =  fabric["(#{i},#{j})"].nil? ? 1 : fabric["(#{i},#{j})"] + 1
    end
  end
end
file.close
puts fabric
fabric.each { |x,y| result+=1 if y > 1}
puts result


