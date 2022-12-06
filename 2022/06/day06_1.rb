datastream = []
file = File.new("input.txt", "r")
while (line = file.gets)
    datastream = line.split("")
end
file.close

pos = 0
while pos+4 < datastream.length
    #puts datastream[pos,4].uniq.join("")

    if datastream[pos,4].uniq.length == 4
        puts datastream[pos,4]
        break
    end
    pos += 1
end

puts pos+4