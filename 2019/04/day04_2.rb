# An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.

# Given this additional criterion, but still ignoring the range rule, the following are now true:

# 112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
# 123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
# 111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).
# How many different passwords within the range given in your puzzle input meet all of the criteria?

# 1120 too high

start = 231832
finish = 767346

nr_of_passwords = 0

def check_doublet(candidate)
	(0..candidate.length-1).each do |i|		

		if (i == 0 && candidate[i].to_i == candidate[i+1].to_i && candidate[i+1].to_i != candidate[i+2].to_i )
			#puts "1) #{i} : #{candidate[i]} - #{candidate[i+1]}"
			return true
		elsif (i != 0 && candidate[i+2].nil? && 
					candidate[i].to_i == candidate[i+1].to_i && 
					candidate[i].to_i != candidate[i-1].to_i)
			#puts "2) #{i} : #{candidate[i]} - #{candidate[i+1]}"
			return true
		elsif (i != 0 && !candidate[i+2].nil? && 
				  candidate[i].to_i == candidate[i+1].to_i && 			
					candidate[i].to_i != candidate[i-1].to_i &&
					candidate[i+1].to_i != candidate[i+2].to_i)
			#puts "3) #{i} : #{candidate[i]} - #{candidate[i+1]}"
			return true
		end			
	end
	return false
end

def check_no_decrease(candidate)
	(0..candidate.length-2).each do |i|
		return false if candidate[i].to_i > candidate[i+1].to_i
	end
	return true
end

(start..finish).each do |candidate|
	nr_of_passwords += 1 if check_doublet(candidate.to_s) && check_no_decrease(candidate.to_s)
end

puts "res : #{nr_of_passwords}"

