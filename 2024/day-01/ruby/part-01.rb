list_path = File.join(__dir__, "list.txt")

left_list = []
right_list = []

File.foreach(list_path) do |line|
  left_element, right_element = line.split(" ")
  left_list << left_element.to_i
  right_list << right_element.to_i
end

left_list.sort!
right_list.sort!

distance = left_list.size.times.reduce(0) do |sum, index|
  sum + (left_list[index] - right_list[index]).abs
end

puts distance
