input_path = File.join(__dir__, "input.txt")

regex = %r{mul\((?<a>\d{1,3}),(?<b>\d{1,3})\)}

mult_operations = []

content =  File.read(input_path)

dont_index = content.index("don't()")

while dont_index
  do_index = content.index("do()", dont_index)

  if do_index
    content.slice!(dont_index, do_index+4-dont_index)
  else
    content.slice!(dont_index, content.length - 1)
  end

  dont_index = content.index("don't()")
end

mult_operations = content.scan(regex)

puts mult_operations.sum { |a, b| a.to_i * b.to_i }
