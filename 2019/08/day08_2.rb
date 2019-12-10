width = 25
height = 6

input = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  input = line
end
file.close


nr_of_pixels = input.length
i = 0
pixels = []
while (i < nr_of_pixels)
  layer = []
  (1..height).each do |p|
    layer.push input[i..i+width-1].split(//)
    i += width
  end
  pixels.push layer 
end

res_layer = []
(1..height).each do |i|
  res_layer.push Array.new(width) { |i| nil }
end

la = 0
pixels.each do |layer|
  ln = 0
  layer.each do |line|
    c = 0
    line.each do |column|
      if res_layer[ln][c].nil? || res_layer[ln][c] == "2"
        column = " " if column == "0"
        res_layer[ln][c] = column 
      end      
      c += 1
    end
    ln += 1
  end
  la +=1
end

# print answer
res_layer.each do |layer|
  puts layer.join()
end