#52821228905 to high

bags = {}
lines = []
file = File.new("input_test.txt", "r")
while (line = file.gets)  
  res = line.scan(/^(.*) bags contain (\d+ .* bags?)*/)
  res = res[0] unless res.nil?
  contains = {}
  unless res[1].nil?
    res[1].split(",").each do |r|
      c_res = r.scan(/(\d)+ (.*) bag.*/)
      unless c_res.nil?
        c_res = c_res[0]
        contains[c_res[1]] = c_res[0] if c_res.length == 2
      end
    end
  end
  bags[res[0]] = contains
end
file.close

def traverse_bags(bag, bags)
  res = 1

  if bags[bag].empty?
    res = 1
  else
    bags[bag].each do |k, v|
      res += v.to_i * traverse_bags(k, bags)
    end
  end
  res
end

res = traverse_bags("shiny gold", bags)-1
puts res

