# frozen_string_literal: true

require 'ostruct'
require 'set'

def board_printer(board)
  board.each do |row|
    row = row.map { |i| "(#{i.num}, #{i.is_marked})" }
  end
  puts board.to_a.map(&:inspect)
end

def initialize_boards(board_file)
  board_array = []
  in_array = File.readlines(board_file).map(&:split)
  board_count = (in_array.length + 1) / 6
  0.upto(board_count - 1).each do |i|
    board_array.append(in_array[i * 6, 5])
  end
  board_array
end

def initialize_board_map(game_board)
  value_hashmap = {}

  0.upto(game_board.length - 1).each do |b|
    0.upto(game_board[b].length - 1).each do |y|
      0.upto(game_board[b][y].length - 1).each do |x|
        field = OpenStruct.new
        field.num = game_board[b][y][x]
        field.is_marked = false
        game_board[b][y][x] = field
        hash_entry = value_hashmap[field.num]
        hash_entry.nil? ? value_hashmap[field.num] = [[b, y, x]] : value_hashmap[field.num].append([b, y, x])
      end
    end
  end
  value_hashmap
end

def check_board_orientation(board)
  board.each do |row|
    bingo = true
    i = 0
    while bingo && i < row.length
      bingo = row[i].is_marked
      i += 1
    end
    return bingo if bingo
  end
  false
end

def board_is_bingo(board)
  # board_printer(board)
  if check_board_orientation(board) || check_board_orientation(board.transpose)
    true
  else
    false
  end
end

def final_score(board, input)
  sum = 0
  board.each do |row|
    row.each do |col|
      sum += col.num.to_i if !col.is_marked
    end
  end
  sum * input.to_i
end

def play_game(game_boards, game_map, inputs)
  inputs.each do |input|
    game_map[input].each do |coords|
      game_boards[coords[0]][coords[1]][coords[2]].is_marked = true
      return final_score(game_boards[coords[0]], input) if board_is_bingo(game_boards[coords[0]])
    end
  end
end

def play_game_last_win(game_boards, game_map, inputs)
  winners = Set[]
  inputs.each do |input|
    game_map[input].each do |coords|
      game_boards[coords[0]][coords[1]][coords[2]].is_marked = true
      winners.add(coords[0]) if board_is_bingo(game_boards[coords[0]])
      return final_score(game_boards[coords[0]], input) if winners.length == game_boards.length
    end
  end
  'none'
end

game_boards = initialize_boards('4-dec/resources/puzzle/boards')
game_map = initialize_board_map(game_boards)
inputs = File.foreach('4-dec/resources/puzzle/number-input').first.split(',')

# puts 'Game Boards'
# puts game_boards.to_a.map(&:inspect)
# puts 'Game Map'
# puts game_map.to_a.map(&:inspect)
# puts 'Inputs'
# puts inputs

puts play_game(game_boards, game_map, inputs)
puts play_game_last_win(game_boards, game_map, inputs)
