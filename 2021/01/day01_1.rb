report = []
file = File.new("input.txt", "r")
while (line = file.gets)
  report.push(line.to_i)
end
file.close

increases      = 0
previous_depth = nil

report.each do |depth|  
  if !previous_depth.nil? && depth > previous_depth
    increases += 1
  end
  previous_depth = depth
end

puts increases