asssignments = []
file = File.new("input.txt", "r")
while (line = file.gets)
    pair = []
    pair << line.split(",")[0].split("-")
    pair << line.split(",")[1].split("-")
    asssignments.push(pair)
end
file.close

cointained_pair = 0
asssignments.each do |a|
    if (a[0][0].to_i >= a[1][0].to_i && a[0][1].to_i <= a[1][1].to_i)
        cointained_pair += 1
    elsif (a[1][0].to_i >= a[0][0].to_i && a[1][1].to_i <= a[0][1].to_i)
        cointained_pair += 1
    end
end

puts cointained_pair
