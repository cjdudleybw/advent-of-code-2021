# frozen_string_literal: true

require 'ostruct'
require 'set'

def expand_grid(grid)
  big_grid = Array.new(grid.length * 5) { Array.new(grid[0].length * 5, 0) }
  0.upto(grid.length - 1).each do |i|
    0.upto(grid[0].length - 1).each do |j|
      big_grid[i][j] = grid[i][j]
    end
  end

  1.upto(4).each do |n|
    0.upto(grid.length - 1).each do |i|
      0.upto(grid[0].length - 1).each do |j|
        new_num = grid[i][j] + n
        big_grid[(n * grid.length) + i][j] = new_num < 10 ? new_num : new_num - 9
      end
    end
  end
  1.upto(4).each do |n|
    0.upto(big_grid.length - 1).each do |i|
      0.upto(grid[0].length - 1).each do |j|
        new_num = big_grid[i][j] + n
        big_grid[i][(n * grid[0].length) + j] = new_num < 10 ? new_num : new_num - 9
      end
    end
  end
  big_grid
end

def get_neighbours(grid, u)
  n = []
  n.append([u[0] - 1, u[1]]) unless u[0] == 0
  n.append([u[0] + 1, u[1]]) unless u[0] == grid.length - 1
  n.append([u[0], u[1] - 1]) unless u[1] == 0
  n.append([u[0], u[1] + 1]) unless u[1] == grid[0].length - 1
  n
end

def safest_path(grid)
  fastest_path = Hash.new(9_999_999_999)

  height = grid.length
  width = grid[0].length

  to_consider = [[0, 0]]
  fastest_path[[0, 0]] = 0

  while next_node = to_consider.shift
    x, y = next_node
    cost = fastest_path[[y, x]]

    get_neighbours(grid, [x, y]).each do |nx, ny|
      neighbor_cost = grid[ny][nx]
      next unless cost + neighbor_cost < fastest_path[[ny, nx]]

      fastest_path[[ny, nx]] = cost + neighbor_cost
      to_consider << [nx, ny]
    end
  end

  puts fastest_path[[height - 1, width - 1]]
end

def solution(file)
  grid = expand_grid(File.readlines(file).map(&:strip).map(&:chars).map { |line| line.map(&:to_i) })
  # grid = File.readlines(file).map(&:strip).map(&:chars).map { |line| line.map(&:to_i) }
  fastest2(grid)
end

solution('15-dec/resources/test/input')
