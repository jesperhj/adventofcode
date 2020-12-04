lines = []
l = ""
file = File.new("input.txt", "r")
while (line = file.gets)
  if line.length == 1 || l == ""
    lines << l if l != ""
    l = line.strip
  else
    l = l + " " + line.strip
  end
end
file.close
lines << l if l != ""

valid_passports = 0
lines.each do |l|
  passport = l.split
  if passport.length == 8 || (passport.length == 7 && !l.include?("cid"))
    is_valid = true
    passport.each do |f|
      field = f.split(":")
      case field[0]
        when "byr"
          is_valid = false if field[1].to_i < 1920 || field[1].to_i > 2002
        when "iyr"
          is_valid = false if field[1].to_i < 2010 || field[1].to_i > 2020
        when "eyr"
          is_valid = false if field[1].to_i < 2020 || field[1].to_i > 2030
        when "hgt"
          res = /(\d+)(.*)/.match(field[1])
          if res.length == 3
            height = res[1].to_i
            unit = res[2]
            is_valid = false unless (unit == "cm" && height <= 193 && height >= 150) ||
            (unit == "in" && height <= 76 && height >= 59)
          else
            is_valid = false
          end             
        when "hcl"
          is_valid = false if /#[a-z0-9]{6}$/.match(field[1]).nil?
        when "ecl"
          is_valid = false unless ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include? field[1]
        when "pid"
          is_valid = false if /^\d{9}$/.match(field[1]).nil?
      end
    end
    valid_passports += 1 if is_valid
  end
end

puts valid_passports