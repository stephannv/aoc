input_path = File.join(__dir__, "input.txt")

regex = %r{mul\((?<a>\d{1,3}),(?<b>\d{1,3})\)}

mult_operations = []

File.foreach(input_path) do |line|
  mult_operations += line.scan(regex)
end

puts mult_operations.sum { |a, b| a.to_i * b.to_i }
