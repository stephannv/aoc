input_path = File.join(__dir__, "input.txt")

ordering_rules = []
updates = []

File.foreach(input_path) do |line|
  if line.include?("|")
    ordering_rules << line.strip.split("|").map(&:to_i)
  elsif line.include?(",")
    updates << line.strip.split(",").map(&:to_i)
  end
end

class Page
  attr_reader :number, :next_pages

  def initialize(number)
    @number = number
    @next_pages = []
  end

  def has_next_page?(page_number)
    next_pages.any? { |page| page.number == page_number }
  end
end

pages = {}

ordering_rules.each do |rule|
  page_number, next_page_number = rule
  pages[page_number] ||= Page.new(page_number)
  pages[next_page_number] ||= Page.new(next_page_number)
  pages[page_number].next_pages << pages[next_page_number]
end

def correct_update?(update, pages)
  result = update.map.with_index do |page, index|
    next true if index == 0

    current_page = pages[page]

    update[0...index].none? { |prev_page_number| current_page.has_next_page?(prev_page_number) }
  end

  result.all?
end

correct_updates = updates.filter do |update|
  correct_update?(update, pages)
end

p correct_updates.map { |update| update[update.size / 2] }.sum
