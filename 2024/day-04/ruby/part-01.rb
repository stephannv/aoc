input_path = File.join(__dir__, "input.txt")

data = []

File.foreach(input_path) { |line| data << line.strip }

DIRECTIONS = {
  left: [-1,0],
  right: [1,0],
  up: [0,-1],
  down: [0,1],
  up_left: [-1,-1],
  up_right: [1,-1],
  down_right: [1,1],
  down_left: [-1,1]
}

map_width = data[0].size
map_height = data.size

map = Array.new(map_height) { Array.new(map_width) }

data.each_with_index do |string, y|
  string.chars.each_with_index do |char, x|
    map[x][y] = char
  end
end

def get_word(map, x, y, dx, dy, count)
  count.times.map do |d|
    char_x = x + d * dx
    char_y = y + d * dy

    next if char_x < 0 || char_y < 0

    map.dig char_x, char_y
  end.compact.join
end

count = 0

map_height.times do |y|
  map_width.times do |x|
    if map[x][y] == "X"
      DIRECTIONS.each do |name, direction|
        word = get_word(map, x, y, *direction, 4)

        if word == "XMAS"
          count += 1
        end
      end
    end
  end
end

puts count
