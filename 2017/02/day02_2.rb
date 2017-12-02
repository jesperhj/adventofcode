
def check_number(number, line)
  sum = 0
  line.each do |n|
    if number != n && number > n && number % n == 0
      sum += number / n
    end
  end
  return sum
end

def check_line(line)
  res = 0
  line.each do |number|
    res += check_number(number,line)
  end
  return res
end

sum = 0
file = File.new("input.txt", "r")
while (l = file.gets)
  line = Array.new
  l.strip.split(" ").each do |num|
    line.push(num.to_i)
  end
  sum += check_line(line)
end
file.close

puts sum
