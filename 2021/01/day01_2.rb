report = []
file = File.new("input.txt", "r")
while (line = file.gets)
  report.push(line.to_i)
end
file.close

increases      = 0
previous_depth = nil

for i in 0..report.length()-1
  next if [0,report.length()-1].include?(i)

  depth = report[i-1]+report[i]+report[i+1]
  if !previous_depth.nil? && depth > previous_depth
    increases += 1
  end
  previous_depth = depth
end

puts increases
