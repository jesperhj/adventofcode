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

# find layer with fewest 0 digits
layer = 0
res_layer = 0
previous_winner = 0
fewest_digit = "0"
while layer < pixels.length
  nr_of_digits = 0

  pixels[layer].each do |p|
    p.each do |l|
      nr_of_digits += 1 if l != fewest_digit
    end
  end

  if nr_of_digits > previous_winner
    previous_winner = nr_of_digits
    res_layer = layer
  end

  layer += 1
end

# find checksum
res = { "1" => 0, "2" => 0}
pixels[res_layer].each do |p|
  p.each do |l|
    res["1"] += 1 if l == "1"
    res["2"] += 1 if l == "2"
  end
end

puts "layer : #{res_layer+1}"
puts "#{res["1"]}x#{res["2"]} = #{res["1"]*res["2"]}"