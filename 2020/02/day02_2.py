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
	pos1 = int(i[0])-1
	pos2 = int(i[1])-1
		
	if ( (i[3][pos1] == i[2]) ^ (i[3][pos2] == i[2]) ):
		valid_passwords += 1

print(valid_passwords)