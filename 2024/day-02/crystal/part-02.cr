list_path = File.join(__DIR__, "list.txt")

reports = [] of Array(Int32)

File.each_line(list_path) do |line|
  reports << line.split(" ").map(&.to_i)
end

def order_safe?(report : Array(Int32))
  report == report.sort || report == report.sort.reverse
end

def adjacent_safe?(report : Array(Int32))
  report.each_cons(2).to_a.all? do |cons|
    (1..3).covers? (cons.first - cons.last).abs
  end
end

def safe_report?(report : Array(Int32))
  order_safe?(report) && adjacent_safe?(report)
end

safe_reports = reports.select do |report|
  safe_report?(report) || report.combinations(report.size - 1).any? { |sub_report| safe_report?(sub_report) }
end

puts safe_reports.size
