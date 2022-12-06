stacks = []
moves = []
get_cargo = true
file = File.new("input.txt", "r")

while (line = file.gets)
    if line.include?("1") && !line.include?("m") # finished loading cargo to stacks
        get_cargo = false
        next
    end

    if get_cargo
        i=0
        while line.length >= 3
            cargo = line.slice!(0..2)           # get potential cargo
            stacks[i] = [] if stacks[i].nil?    # prepare stacks
            if cargo[1] != " "                  # load potential cargo to stack
                stacks[i] << cargo[1] 
            end
            line.slice!(1) if line.length > 0   # move to next cargo

            i += 1
        end
    else
        #puts line
        input = line.scan(/move (\d+) from (\d+) to (\d+)/)[0]
        if !input.nil?
            moves << input
        end
    end
end
file.close

moves.each do |m|
    nr_of = m[0].to_i
    from_stack = m[1].to_i-1
    to_stack = m[2].to_i-1
    cargo = stacks[from_stack].shift(nr_of)

    cargo.reverse.each do |c|
        stacks[to_stack].unshift(c)
    end
end

res = []
stacks.each do |s|
    res << s[0]
end
puts res.join("")