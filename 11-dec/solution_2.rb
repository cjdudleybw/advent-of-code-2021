# frozen_string_literal: true
# frozen_string_literal: true

def flash(grid, i, j)
  grid[i][j]['flash'] = true
  grid[i][j]['num'] = 0
  all_y = (i - 1).upto(i + 1).reject { |y| y.negative? || y >= grid.length }.to_a
  all_x = (j - 1).upto(j + 1).reject { |x| x.negative? || x >= grid[0].length }.to_a
  all_y.product(all_x).each do |pair|
    increment(grid, pair[0], pair[1])
  end
end

def increment(grid, i, j)
  grid[i][j]['num'] = grid[i][j]['num'] + 1 unless grid[i][j]['flash']
  flash(grid, i, j) if grid[i][j]['num'] == 10
end

def do_step(grid)
  grid.map { |row| row.map { |col| col['flash'] = false } }
  0.upto(grid.length - 1).each do |i|
    0.upto(grid[i].length - 1).each do |j|
      increment(grid, i, j)
    end
  end
end

def all_flash(grid)
  grid_length = grid.flatten.length
  grid.flatten.select { |cell| cell['flash'] }.length == grid_length
end

def solution(file)
  grid = File.readlines(file).map(&:strip).map(&:chars).map { |r| r.map { |c| { 'num' => c.to_i, 'flash' => false } } }
  steps = 0
  until all_flash(grid)
    do_step(grid)
    steps += 1
  end
  steps
end

puts solution('11-dec/resources/puzzle/input')
