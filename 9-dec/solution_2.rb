# frozen_string_literal: true

require 'ostruct'
require 'set'

def is_lowest(i, j, h_map)
  lowest = true
  lowest &&= h_map[i][j] < h_map[i][j - 1] if j.positive?
  lowest &&= h_map[i][j] < h_map[i][j + 1] if j < h_map[i].length - 1
  lowest &&= h_map[i][j] < h_map[i - 1][j] if i.positive?
  lowest &&= h_map[i][j] < h_map[i + 1][j] if i < h_map.length - 1
  lowest
end

def build_h_map(file)
  File.readlines(file).map(&:strip).map(&:to_s).map(&:chars).map { |chars| chars.map(&:to_i) }
end

def get_low_points(h_map)
  low_points = []
  0.upto(h_map.length - 1).each do |i|
    0.upto(h_map[i].length - 1).each do |j|
      next unless is_lowest(i, j, h_map)

      low = OpenStruct.new
      low.val = h_map[i][j]
      low.coords = [i, j]
      low_points.append(low)
    end
  end
  low_points
end

def get_neighbours(coords, h_map)
  i = coords[0]
  j = coords[1]
  neighbours = []
  neighbours.append([i, j - 1]) if j.positive?
  neighbours.append([i, j + 1]) if j < h_map[i].length - 1
  neighbours.append([i - 1, j]) if i.positive?
  neighbours.append([i + 1, j]) if i < h_map.length - 1
  neighbours
end

def basin_recursive_search(basin_points, coords, h_map)
  if h_map[coords[0]][coords[1]] < 9 && !basin_points.include?(coords)
    basin_points.add(coords)
    get_neighbours(coords, h_map).each do |neighbour|
      basin_points = basin_recursive_search(basin_points, neighbour, h_map)
    end
  end
  basin_points
end

def find_largest_basin(file)
  h_map = build_h_map(file)
  lows = get_low_points(h_map)
  basins = []
  lows.each do |low|
    basin_points = Set[]
    basin_recursive_search(basin_points, low.coords, h_map)
    basins.append(basin_points)
  end
  basins.map(&:length).sort.reverse[0..2].inject(:*)
end

puts find_largest_basin('9-dec/resources/puzzle/input')
