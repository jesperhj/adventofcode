passwords = []
file = open("input.txt", "r") 
for line in file:
	tmp = line.strip().split()
	
	password = tmp[0].split("-")
	passwords.append(password)

	password.append(tmp[1].strip(":"))
	password.append(tmp[2])

valid_passwords = 0
for i in passwords:
	count = i[3].count(i[2])
	if(count >= int(i[0]) and count <= int(i[1])):
		valid_passwords += 1

print(valid_passwords)