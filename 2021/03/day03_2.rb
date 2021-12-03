report = []
file = File.new("input.txt", "r")
while (line = file.gets)
  report.push(line.strip)
end
file.close

# oxygen
oxygen = report.clone()
i = 0
while oxygen.length > 1
  oxygen_left = []
  sum_of_bits = 0

  for j in 0..oxygen.length-1
    sum_of_bits += oxygen[j][i].to_i
  end

  bit = sum_of_bits >= (oxygen.length/2.to_f).ceil ? 1 : 0

  for j in 0..oxygen.length-1       
    if oxygen[j][i].to_i == bit
      oxygen_left.push(oxygen[j])
    end    
  end

  oxygen = oxygen_left
  i += 1  
end

# co2
co2 = report.clone()
i = 0
while co2.length > 1
  co2_left = []
  sum_of_bits = 0

  for j in 0..co2.length-1
    sum_of_bits += co2[j][i].to_i
  end

  bit = sum_of_bits >= (co2.length/2.to_f).ceil ? 0 : 1

  for j in 0..co2.length-1       
    if co2[j][i].to_i == bit
      co2_left.push(co2[j])
    end    
  end

  co2 = co2_left
  i += 1  
end

res = oxygen[0].to_i(2)*co2[0].to_i(2)
puts res


