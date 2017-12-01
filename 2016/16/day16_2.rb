#!/bin/ruby

data = "10011111011011001"
max_length = 35651584

def dragonize(a)
  data = a + "0" + (a.reverse.chars.map {|x| (x == "1") ? "0" : "1"  } * "")
end

def generate_random_data(data, max_length)
  while(data.length < max_length) do
    data = dragonize(data)
  end
  data[0..max_length-1]
end

# break the string into shorter strings to work with to increase speed
def temp(data)
  i = 0
  size = 100000
  cs = ""
  while i < data.length
    d = data[i..i+size]
    cs += generate_checksum(d)
    i += size
  end
  cs
end

def generate_checksum(data)
  checksum = "0"*(data.length/2)

  (0..checksum.length-1).each do |i|
    checksum[i] = "1" if data[2*i] == data[2*i+1]
  end

  return checksum
end

def get_checksum(data)
  checksum = temp(data)
  puts "#{checksum.length}"
  while (checksum.length % 2 == 0)
    if checksum.length > 100000
      checksum = temp(checksum)
    else
      checksum = generate_checksum(checksum)
    end
  end
  return checksum
end

data = generate_random_data(data, max_length)
puts "data #{data.length}"
checksum = get_checksum(data)
puts "checksum #{checksum}"
