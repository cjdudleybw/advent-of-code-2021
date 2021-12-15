# frozen_string_literal: true

def solution(file)
  grid = File.readlines(file).map(&:strip).map(&:chars).map { |line| line.map(&:to_i) }
  memo = Array.new(grid.length) { Array.new(grid[0].length, 0) }
  
  # Set min top row
  1.upto(grid[0].length - 1).each do |i|
    memo[0][i] = grid[0][i] + memo[0][i - 1]
  end

  # set min left col
  1.upto(grid.length - 1).each do |i|
    memo[i][0] = grid[i][0] + memo[i - 1][0]
  end

  # find cheapest route to each square
  1.upto(grid.length - 1).each do |i|
    1.upto(grid[0].length - 1).each do |j|
      memo[i][j] = grid[i][j] + [memo[i][j - 1], memo[i - 1][j]].min
    end
  end

  memo.last.last
end

puts solution('15-dec/resources/puzzle/input')
