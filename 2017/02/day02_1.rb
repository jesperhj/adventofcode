
sum = 0
file = File.new("input.txt", "r")
while (line = file.gets)
  min = nil
  max = 0
  line.strip.split(" ").each do |num|
    num = num.to_i
    min = num if min.nil? || num < min
    max = num if num > max
  end
  sum += max-min
end
puts sum
file.close
