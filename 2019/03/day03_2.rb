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
	steps = 0
	path["#{x},#{y}"] = 0
	wire.each do |step|
		#puts step
		direction = step[0]
		step[0] = ''
		move = step.to_i		
		case direction
		when "R"
			(1..move).each do |i| steps += 1; path["#{x+i},#{y}"] = steps end
			x = x+move
		when "L"			
			(1..move).each do |i| steps += 1; path["#{x-i},#{y}"] = steps end
			x = x-move
		when "U"
			(1..move).each do |i| steps += 1; path["#{x},#{y+i}"] = steps end
			y = y+move
		when "D"
			(1..move).each do |i| steps += 1; path["#{x},#{y-i}"] = steps end
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
		#d = (coords[0].to_i.abs+coords[1].to_i.abs)
		steps_traveled = paths[0][k].to_i + paths[1][k].to_i
		dist.push(steps_traveled)
		#puts "#{k} => #{steps_traveled}"
	end
end
#puts dist
puts "res : #{dist.sort.first}"
