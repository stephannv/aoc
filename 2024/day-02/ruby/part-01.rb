list_path = File.join(__dir__, "list.txt")

reports = []

File.foreach(list_path) do |line|
  reports << line.split(" ").map(&:to_i)
end

safe_reports = reports.filter do |report|
  if report != report.sort && report != report.sort.reverse
    next false
  end

  report.each_cons(2).to_a.all? do |cons|
    (1..3).cover? (cons.first - cons.last).abs
  end
end

puts safe_reports.size
