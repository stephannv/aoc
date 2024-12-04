input_path = File.join(__DIR__, "input.txt")

regex = %r{mul\((?<a>\d{1,3}),(?<b>\d{1,3})\)}

mult_operations = [] of Regex::MatchData

File.each_line(input_path) do |line|
  mult_operations += line.scan(regex)
end

puts mult_operations.sum { |d| d["a"].to_i * d["b"].to_i }
