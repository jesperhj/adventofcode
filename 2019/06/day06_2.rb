orbits_k = {}
orbits_v = {}
nr_of_orbits_k = {}
nr_of_orbits_v = {}
orbit_paths = {} 
file = File.new("input.txt", "r")
while (line = file.gets)
  (k,v) = line.split(')')
  k = k.strip
  v = v.strip

  if orbits_k[k].nil?
    orbits_k[k] = [v]
    nr_of_orbits_k[k] = 0
  else
    orbits_k[k].push(v)
  end
  if orbits_v[v].nil?
    orbits_v[v] = k
    nr_of_orbits_v[v] = 0
    orbit_paths[v] = []
  else
    orbits_v[v].push(k)
  end
  #puts "#{k} ) #{v}"
end
file.close

def find_distance(orbits, nr_of_orbits, planet, center)
  #puts "#{planet} ( #{center}"
  if(orbits[center].nil?)
    nr_of_orbits[planet] = 1
  elsif(nr_of_orbits[center] == 0)
    nr_of_orbits[planet] = find_distance(orbits, nr_of_orbits, center, orbits[center]) + 1
  else
    nr_of_orbits[planet] = nr_of_orbits[center] + 1
  end    
end

def calculate_nr_of_moves(nr_of_orbits_v, common_node)
  res = nr_of_orbits_v["SAN"] - 1 + nr_of_orbits_v["YOU"] - 1 - nr_of_orbits_v[common_node]*2
  puts "#{nr_of_orbits_v["SAN"]-1} + #{nr_of_orbits_v["YOU"]-1} - #{nr_of_orbits_v[common_node]} * 2 = #{res}"
end

def set_paths(orbits, nr_of_orbits, start, node, orbit_paths)
  orbit_paths[start].push(node)

  if node != "COM"
    set_paths(orbits, nr_of_orbits, start, orbits[node], orbit_paths)
  end

end

def find_common_node(orbit_paths)
  orbit_paths["YOU"].each do |i|
    orbit_paths["SAN"].each do |j|
      return i if i == j
    end
  end
  return "COM"
end

orbits_v.each do |k,v|  
  find_distance(orbits_v, nr_of_orbits_v, k, v)
end


set_paths(orbits_v,nr_of_orbits_v, "YOU", orbits_v["YOU"], orbit_paths)
set_paths(orbits_v,nr_of_orbits_v, "SAN", orbits_v["SAN"], orbit_paths)
common_node = find_common_node(orbit_paths)
calculate_nr_of_moves(nr_of_orbits_v, common_node)

