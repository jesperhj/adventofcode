#!/bin/ruby
claims = []
result = 0
fabric = {}

file = File.new("input.txt", "r")
while (line = file.gets)
  res = /#(\d*)\s@\s(\d*),(\d*):\s(\d*)x(\d*)/.match(line)
  claims << line
  claim = res[1].to_i
  coordinates = [res[2].to_i,res[3].to_i]
  size = [res[4].to_i,res[5].to_i]

  (coordinates[0]..coordinates[0]+size[0]-1).each do |i|
    (coordinates[1]..coordinates[1]+size[1]-1).each do |j|
      # to lazy to install tuple gem :)
      if fabric["(#{i},#{j})"].nil?
        fabric["(#{i},#{j})"] = claim
      else
        fabric["(#{i},#{j})"] = 0
      end
    end
  end
end
file.close

claims.each do |c|
  res = /#(\d*)\s@\s(\d*),(\d*):\s(\d*)x(\d*)/.match(c)
  claim = res[1].to_i
  coordinates = [res[2].to_i,res[3].to_i]
  size = [res[4].to_i,res[5].to_i]

  area = size[0]*size[1]
  untouched = 0

  (coordinates[0]..coordinates[0]+size[0]-1).each do |i|
    (coordinates[1]..coordinates[1]+size[1]-1).each do |j|
      # to lazy to install tuple gem :)
      untouched += 1 if fabric["(#{i},#{j})"] == claim
    end
  end

  if area == untouched
    puts "Result #{claim}"
    break
  end
end

fabric.each { |x,y| result+=1 if y != 0}



