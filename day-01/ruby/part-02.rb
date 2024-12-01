list_path = File.join(__dir__, "list.txt")

left_list = []
right_list = []

File.foreach(list_path) do |line|
  left_element, right_element = line.split(" ")
  left_list << left_element.to_i
  right_list << right_element.to_i
end

similarity_scores = left_list.map do |number|
  number * right_list.count(number)
end

puts similarity_scores.sum
