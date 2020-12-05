lines = []
file = File.new("input.txt", "r")
while (line = file.gets)
  lines << line
end
file.close

seating_list = []
highest_id = 0
lines.each do |line|
  i = 0
  min_row = 0.0
  max_row = 127.0
  min_seat = 0.0
  max_seat = 7.0
  while i < line.length   
    if i < 7  # check rows
      if line[i] == "F"
        max_row = (max_row.to_f - (max_row.to_f-min_row.to_f) / 2).floor
      else
        min_row = (min_row.to_f + (max_row.to_f-min_row.to_f) / 2).ceil
      end
    else
    if line[i] == "L"
        max_seat = (max_seat.to_f - (max_seat.to_f-min_seat.to_f) / 2).floor
      else
        min_seat = (min_seat.to_f + (max_seat.to_f-min_seat.to_f) / 2).ceil
      end
    end    
    i += 1
  end
  id = min_row * 8 + min_seat
  seating_list[id] = {"id" => id, "row" => min_row, "seat" => min_seat}  
end

seating_list.each do |seat|
  unless seat.nil?    
    puts seat["id"].to_i-1  if seating_list[seat["id"]-1].nil?
  end
end