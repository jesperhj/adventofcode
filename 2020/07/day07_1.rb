bags = {}
lines = []
file = File.new("input.txt", "r")
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

def traverse_bags(bag, checked, bags)
  bags_found = 0
  checked[bag] = false

  bags[bag].each do |k,v|
    if k == "shiny gold" || (!checked[k].nil? && checked[k])
      bags_found += 1
      checked[bag] = true
      break
    else
      if checked[k].nil?
        if traverse_bags(k, checked, bags) == 1
          bags_found += 1
          break
        end
      end
    end  
  end

  return bags_found
end

res = 0
bags.each do |k,v|
  checked = {}  
  res += traverse_bags(k, checked, bags)  
end
puts res
