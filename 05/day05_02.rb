#!/bin/ruby

require 'digest/md5'

# 0555b8c8
# ef19d993

class PasswordCracker
  def initialize
    @md5 = Digest::MD5.new
    @id  = "wtnhxymk"
    @password = {}
    @i = 0
    @progress = 0
  end

  def find_character
    while true do
      hash = @md5.hexdigest(@id + @i.to_s)
      @i += 1
      if hash[0,5] == "00000"
        return hash
      end
    end
  end

  def solve
    while @progress < 8 do
      hash = find_character
      if hash[5].hex < "8".hex and @password[hash[5]] == nil
        @password[hash[5]] = hash[6]
        @progress += 1
      end
    end
    answer = ""
    @password.sort.each do |k,v|
      answer += v
    end

    puts "Password is #{answer}"
  end
end

password_cracker = PasswordCracker.new

password_cracker.solve


