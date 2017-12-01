#!/bin/ruby

require 'digest/md5'

# 0555b8c8
# ef19d993

class PasswordCracker
  def initialize
    @md5 = Digest::MD5.new
    @id  = "wtnhxymk"
    @password = ""
    @i = 0
  end

  def find_character
    while true do
      hash = @md5.hexdigest(@id + @i.to_s)
      @i += 1
      if hash[0,5] == "00000"
        puts "hash #{hash} - #{hash[5]} #{@id + @i.to_s}"
        return hash[5]
      end
    end
  end

  def solve
    while @password.length < 8 do
      @password += find_character
    end
    puts "Password is #{@password}"
  end
end

password_cracker = PasswordCracker.new

password_cracker.solve


