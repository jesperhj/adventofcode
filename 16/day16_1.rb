#!/bin/ruby

data = "10011111011011001"
max_length = 272

def dragonize(a)
  b = ""
  a.reverse.each_char do |char|
    b += char == "1" ? "0" : "1"
  end
  data = a + "0" + b
end

def generate_random_data(data, max_length)
  while(data.length < max_length) do
      data = dragonize(data)
  end
  data[0..max_length-1] if data.length > max_length
end

def generate_checksum(data)
  checksum = ""
  while(data.length > 1)
    checksum += (data[0] == data[1]) ? "1" : "0"
    data = data [2..data.length-1]
  end
  return checksum
end

def get_checksum(data)
  checksum = generate_checksum(data)
  while (checksum.length % 2 == 0)
    checksum = generate_checksum(checksum)
  end
  return checksum
end

data = generate_random_data(data, max_length)
checksum = get_checksum(data)
puts "checksum #{checksum}"
