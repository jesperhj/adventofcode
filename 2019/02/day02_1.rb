
intcode = [] 
file = File.new("input.txt", "r")
while (line = file.gets)
  intcode = line.split(',')
end
file.close

intcode = intcode.map(&:to_i)
position = 0

def print_intcode(code)
	res = ""
	code.each do |x|
		res += "#{x},"
	end
	puts res
end

# return to 1202 program alarm state
intcode[1] = 12
intcode[2] = 2

#print_intcode(intcode)
while !intcode[position].nil? && intcode[position] != 99 do

	if(intcode[position] == 1)		
		intcode[intcode[position+3]] = intcode[intcode[position+1]] + intcode[intcode[position+2]]
	elsif(intcode[position] == 2)		
		intcode[intcode[position+3]] = intcode[intcode[position+1]] * intcode[intcode[position+2]]
	else
		puts "error at position #{position}"
		break
	end
	position += 4
end

print_intcode(intcode)
puts "res : #{intcode[0]}"