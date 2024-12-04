input_path = File.join(__DIR__, "input.txt")

data = [] of String

File.each_line(input_path) { |line| data << line.strip }

DIRECTIONS = {
  left: {-1,0},
  right: {1,0},
  up: {0,-1},
  down: {0,1},
  up_left: {-1,-1},
  up_right: {1,-1},
  down_right: {1,1},
  down_left: {-1,1}
}

map_width = data[0].size
map_height = data.size

map = Array(Array(Char)).new(map_height) { Array(Char).new(map_width) { '-' } }

data.each_with_index do |row, y|
  row.chars.each_with_index do |char, x|
    map[x][y] = char
  end
end

def get_word(map, x, y, dx, dy, count)
  count.times.compact_map do |d|
    char_x = x + d * dx
    char_y = y + d * dy

    next if char_x < 0 || char_x >= map[0].size || char_y < 0  || char_y >= map.size

    map.dig char_x, char_y
  end.join
end

count = 0

map_height.times do |y|
  map_width.times do |x|
    if map[x][y] == 'A'
      first_diagonal = get_word(map, x-1, y-1, *DIRECTIONS[:down_right], 3)
      second_diagonal = get_word(map, x+1, y-1, *DIRECTIONS[:down_left], 3)

      if (first_diagonal == "MAS" || first_diagonal == "SAM") && (second_diagonal == "MAS" || second_diagonal == "SAM")
        count += 1
      end
    end
  end
end

puts count
