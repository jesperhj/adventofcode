rounds = []
file = File.new("input.txt", "r")
while (line = file.gets)
    rounds.push(line.split(" "))
end
file.close

points = 0
rounds.each do |r|
    case r[0]
    when "A" #rock
        case r[1]
        when "X"
            points += 3+0
        when "Y"
            points += 1+3
        when "Z"
            points += 2+6
        end
    when "B" #paper
        case r[1]
        when "X"
            points += 1+0
        when "Y"
            points += 2+3
        when "Z"
            points += 3+6
        end
    when "C" #scissor
        case r[1]
        when "X"
            points += 2+0
        when "Y"
            points += 3+3
        when "Z"
            points += 1+6
        end
    end
end
puts points