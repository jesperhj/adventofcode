report = []
file = File.new("input.txt", "r")
while (line = file.gets)
  report.push(line.to_i)
end
file.close

report.each do |i|
  report.each do |j|
    if( i + j == 2020)
      puts i*j
      exit
    end
  end
end
