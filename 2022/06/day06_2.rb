datastream = []
file = File.new("input.txt", "r")
while (line = file.gets)
    datastream = line.split("")
end
file.close

pos = 0
while pos+14 < datastream.length
    if datastream[pos,14].uniq.length == 14
        puts datastream[pos,14]
        break
    end
    pos += 1
end

puts pos+14