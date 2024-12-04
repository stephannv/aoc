input_path = File.join(__DIR__, "input.txt")

regex = %r{mul\((?<a>\d{1,3}),(?<b>\d{1,3})\)}

mult_operations = [] of Regex::MatchData

content = File.read(input_path)

dont_index = content.index("don't()")

while dont_index
  do_index = content.index("do()", dont_index)

  if do_index
    content = content.delete_at dont_index, do_index+4-dont_index
  else
    content = content.delete_at dont_index, content.size - 1
  end

  dont_index = content.index("don't()")
end

mult_operations = content.scan(regex)

puts mult_operations.sum { |d| d["a"].to_i * d["b"].to_i }
