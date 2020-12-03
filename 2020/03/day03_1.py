lines = []
file = open("input.txt", "r") 
for line in file:
  lines.append(line.strip())

x, y, encounters = 0, 0, 0

while(y < len(lines)-1):
  y += 1
  x += 3
  if x >= len(lines[0]):
    x = x % len(lines[0])
  
  if lines[y][x] == "#":
    encounters += 1

print(encounters)