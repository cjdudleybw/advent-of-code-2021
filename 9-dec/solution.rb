# frozen_string_literal: true

def is_lowest(i, j, h_map)
  lowest = true
  lowest &&= h_map[i][j] < h_map[i][j - 1] if j.positive?
  lowest &&= h_map[i][j] < h_map[i][j + 1] if j < h_map[i].length - 1
  lowest &&= h_map[i][j] < h_map[i - 1][j] if i.positive?
  lowest &&= h_map[i][j] < h_map[i + 1][j] if i < h_map.length - 1
  lowest
end

def heightmap(file)
  low_points = []
  h_map = File.readlines(file).map(&:strip).map(&:to_s).map(&:chars).map { |chars| chars.map(&:to_i) }
  0.upto(h_map.length - 1).each do |i|
    0.upto(h_map[i].length - 1).each do |j|
      low_points.append(h_map[i][j]) if is_lowest(i, j, h_map)
    end
  end
  low_points.map { |p| p + 1}.sum
end

puts heightmap('9-dec/resources/puzzle/input')
