rucksacks = []
file = File.new("input.txt", "r")
while (line = file.gets)
    rucksacks.push(line.split(""))
end
file.close

group = []
prios = 0
rucksacks.each do |rs|
    group << rs
    if group.length == 3
        item = group[0] & group[1] & group[2]
        if item[0].ord >= "a".ord
            prios += item[0].ord - "a".ord+1
        else
            prios += item[0].ord - "A".ord+27
        end
        group = []
    end
end
puts prios