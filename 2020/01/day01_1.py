report = []
file = open("input_test.txt", "r") 
for line in file:
	report.append(int(line.strip()))

for i in report:
	for j in report:
		if i+j == 2020:		
			print(i*j)
			exit()
		

