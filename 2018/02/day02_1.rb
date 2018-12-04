#!/bin/ruby

file = File.new("input.txt", "r")
results = {
  2 => 0,
  3 => 0
}

while (line = file.gets)
  # init a hash to use for counting
  counting = {}
  foo =
  ('a'..'z').to_a.each do |x|
    counting[x] = 0
  end

  # iterate over line and count letters
  line.strip.split("").each do |x|
    counting[x] = counting[x] + 1
  end

  # see what we got, can be written much better
  counting.each do |x,y|
    if y == 2
      results[2] = results[2] + 1
      break
    end

  end
  counting.each do |x,y|
    if y == 3
      results[3] = results[3] + 1
      break
    end
  end

end
file.close

puts "Results #{results[2]*results[3]}"

