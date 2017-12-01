#!/bin/ruby

require 'digest/md5'


class PasswordCracker
  def initialize
    @md5  = Digest::MD5.new
    @salt = "zpqevtbw"
    @i = 0
    @intput = ""
    @triplets = {}
    @keys = []
  end

  def stretch_hash
    hash = @salt + @i.to_s
    (0..2016).each do |j|
      hash = @md5.hexdigest(hash)
    end
    return hash
  end

  def find_match
    while @keys.length < 64 do
      hash = stretch_hash
      triplet = ["", "", ""]
      fivelet = ["", "", "", "", ""]

      hash.each_char do |char|
        triplet.push(char)
        triplet.delete_at(0)
        fivelet.push(char)
        fivelet.delete_at(0)

        if fivelet[0] == fivelet[1] && fivelet[0] == fivelet[2] &&
           fivelet[0] == fivelet[3] && fivelet[0] == fivelet[4]
           @triplets.each do |k,v|
              if v == char
                if @i != k.to_i
                  if @i - k.to_i <= 1000 &&
                    @keys.push(k)
                    puts "#{@i}: [#{k.to_i}] = #{char} - #{hash}"
                  end
                  @triplets.delete(k) # we don't need it anymore
                end
              end
           end
        end

        if @triplets[@i] == nil && triplet[0] == triplet[1] && triplet[0] == triplet[2]
          @triplets[@i] = char
        end

      end
      @i += 1

    end

    if @i < 90
      puts "#{@i}: [#{k.to_i}] = #{char} - #{hash}"
    end

    puts "index = #{@keys.sort[63]}"

  end

  def solve
    find_match
  end
end

password_cracker = PasswordCracker.new

password_cracker.solve


