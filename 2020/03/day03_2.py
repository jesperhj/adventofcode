lines = []
file = open("input.txt", "r") 
for line in file:
  lines.append(line.strip())

trees = 1
slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]

for s in slopes:
  x, y, encounters = 0, 0, 0
  while(y < len(lines)-1):
    y += s[1]
    x += s[0]    
    if x >= len(lines[0]):
      x = x % len(lines[0])    
    if lines[y][x] == "#":
      encounters += 1
  trees *= encounters

print(trees)
  