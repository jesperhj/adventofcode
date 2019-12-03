wires = []
file = File.new("input.txt", "r")
while (line = file.gets)
  wire = line.split(',')
  wires.push(wire)
end
file.close

paths=[]

def trace_path(wire, path)
	x = 0
	y = 0
	path["#{x},#{y}"] = true
	wire.each do |step|
		direction = step[0]
		step[0] = ''
		move = step.to_i
		#puts step
		case direction
		when "R"
			(x..x+move).each do |i| path["#{i},#{y}"] = true end
			x = x+move
		when "L"			
			(x-move..x).each do |i| path["#{i},#{y}"] = true end
			x = x-move
		when "U"
			(y..y+move).each do |i| path["#{x},#{i}"] = true end
			y = y+move
		when "D"
			(y-move..y).each do |i| path["#{x},#{i}"] = true end
			y = y-move
		end
		#puts path
	end
end

wires.each do |w|
	path = {}
	trace_path(w, path)
	paths.push(path)
end

# find intersections between the wire paths
intersections = paths[0].select{|k,_| paths[1].has_key? k}

# find closest intersection
dist = []
intersections.each do |k,v|	
	if k != "0,0"
		coords = k.split(',')
		d = (coords[0].to_i.abs+coords[1].to_i.abs)
		dist.push(d)
		#puts "#{k} => #{d}"
	end
end
#puts dist
puts "res : #{dist.sort.first}"
