#12122 high
rounds = []
file = File.new("input.txt", "r")
while (line = file.gets)
    rounds.push(line.split(" "))
end
file.close

points = 0
rounds.each do |r|
    case r[0]
    when "A"
        case r[1]
        when "X"
            points += 1+3
        when "Y"
            points += 2+6
        when "Z"
            points += 3+0
        end
    when "B"
        case r[1]
        when "X"
            points += 1+0
        when "Y"
            points += 2+3
        when "Z"
            points += 3+6
        end
    when "C"
        case r[1]
        when "X"
            points += 1+6
        when "Y"
            points += 2+0
        when "Z"
            points += 3+3
        end
    end
end
puts points