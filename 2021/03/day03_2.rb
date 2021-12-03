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
  # get sum of bit i
  sum_of_bits = oxygen.sum { |j| j[i].to_i }

  # filter based on if 1 or 0 occured the most in bit i
  bit = sum_of_bits >= (oxygen.length/2.to_f).ceil ? 1 : 0
  oxygen.reject! {|j| j[i].to_i != bit} 
  
  i += 1  
end

# co2
co2 = report.clone()
i = 0
while co2.length > 1
  # get sum of bit i
  sum_of_bits = co2.sum { |j| j[i].to_i }

  # filter based on if 1 or 0 occured the most in bit i
  bit = sum_of_bits >= (co2.length/2.to_f).ceil ? 0 : 1
  co2.reject! {|j| j[i].to_i != bit}

  i += 1  
end

# multiply the two numbers in base 10
res = oxygen[0].to_i(2)*co2[0].to_i(2)
puts res


