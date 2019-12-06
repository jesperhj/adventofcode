orbits_k = {}
orbits_v = {}
nr_of_orbits_k = {}
nr_of_orbits_v = {}
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
  else
    orbits_v[v].push(k)
  end
  #puts "#{k} ) #{v}"
end
file.close

def find_distance(orbits, nr_of_orbits, planet, center)
  #puts "#{center} ) #{planet}"
  if(orbits[center].nil?)
    nr_of_orbits[planet] = 1
  elsif(nr_of_orbits[center] == 0)
    nr_of_orbits[planet] = find_distance(orbits, nr_of_orbits, center, orbits[center]) + 1
  else
    nr_of_orbits[planet] = nr_of_orbits[center] + 1
  end    
end

orbits_v.each do |k,v|  
  find_distance(orbits_v, nr_of_orbits_v, k, v)
end

res = 0
nr_of_orbits_v.each do |k,v|
  res += v
end

puts "res #{res}"
