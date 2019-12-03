
instructions = [] 
file = File.new("input.txt", "r")
while (line = file.gets)
  instructions = line.split(',')
end
file.close

instructions = instructions.map(&:to_i)
desired_value = 19690720 # what we want to find

def print_intcode(code)
	res = ""
	code.each do |x|
		res += "#{x},"
	end
	puts res
end

def run_code(intcode, noun, verb)
	intcode[1] = noun
	intcode[2] = verb
	position = 0
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
	return intcode[0]
end

found_answer = false
(0..99).each do |noun|
	(0..99).each do |verb|
		if(run_code(instructions.dup, noun, verb) == desired_value)
			puts "noun : #{noun} , verb : #{verb} = #{desired_value}"
			puts "result : #{100*noun+verb}"
			found_answer = true
		end
		break if found_answer
	end 
	break if found_answer
end