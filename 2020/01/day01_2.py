report = []
file = open("input.txt", "r") 
for line in file:
  report.append(int(line.strip()))

for i in report:
  for j in report:
    for k in report:
      if i+j+k == 2020:   
        print(i*j*k)
        exit()