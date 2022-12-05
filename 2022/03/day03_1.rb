rucksacks = []
file = File.new("input_test.txt", "r")
while (line = file.gets)
    sack = [line.slice(0,line.length/2).split(""), line.slice(line.length/2,line.length).split("")]
    rucksacks.push(sack)
end
file.close

prios = 0
rucksacks.each do |rs|
    item = rs[0] & rs[1]
    if item[0].ord >= "a".ord
        prios += item[0].ord - "a".ord+1
    else
        prios += item[0].ord - "A".ord+27
    end
end
puts prios