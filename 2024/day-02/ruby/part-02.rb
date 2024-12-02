list_path = File.join(__dir__, "list.txt")

reports = []

File.foreach(list_path) do |line|
  reports << line.split(" ").map(&:to_i)
end

def order_safe?(report)
  report == report.sort || report == report.sort.reverse
end

def adjacent_safe?(report)
  report.each_cons(2).to_a.all? do |cons|
    (1..3).cover? (cons.first - cons.last).abs
  end
end

def safe_report?(report)
  order_safe?(report) && adjacent_safe?(report)
end

safe_reports = reports.filter do |report|
  safe_report?(report) || report.combination(report.size - 1).any? { |sub_report| safe_report?(sub_report) }
end

puts safe_reports.size
