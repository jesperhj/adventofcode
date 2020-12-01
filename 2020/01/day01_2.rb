report = []
file = File.new("input.txt", "r")
while (line = file.gets)
  report.push(line.to_i)
end
file.close

report.each do |i|
  report.each do |j|
    report.each do |k|
      if( i + j + k== 2020)
        puts i*j*k
        exit
      end
    end
  end
end
