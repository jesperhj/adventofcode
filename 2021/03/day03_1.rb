report = []
file = File.new("input.txt", "r")
while (line = file.gets)
  report.push(line.strip)
end
file.close

# sum the number of 1 in all numbers for each bit
sum_of_bits = []
report.each do |i|
  for j in 0..i.length-1
    sum_of_bits[j] = i[j].to_i + (sum_of_bits[j].nil? ? 0 : sum_of_bits[j])
  end 
end

# set 1 if if sum of bits is present in more than 50%
gamma   = ""
epsilon = ""
sum_of_bits.each do |i|
  gamma   += (i > report.length/2) ? "1" : "0"
  epsilon += (i > report.length/2) ? "0" : "1"
end

# multiply the two numbers in base 10
res = gamma.to_i(2)*epsilon.to_i(2)
puts res
