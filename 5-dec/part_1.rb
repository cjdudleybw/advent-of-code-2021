# frozen_string_literal: true

# Stores the bingo board state
class BingoBoard
  def initialize(start_array)
    @board = start_array.map { |a| a.map}
  end
end

# Stores the collection and bingo boards, and applies the input to them
class BingoGame
  def initialize(board_file, input_file)
    @bingo_boards = initialize_boards(board_file)
    @inputs = read_input(input_file)
  end

  def read_input(input_file); end

  def initialize_boards(board_file)
    board_array = []
    in_array = File.readlines(board_file).map(&:split)
    board_count = (in_array.length + 1) / 6
    0.upto(board_count - 1).each do |i|
      board_array.append(BingoBoard.new(in_array[i * 6, 5]))
    end
    board_array
  end

  def play_bingo
    bingo = false
    i = 0
    j = 0
    while !bingo && i < inputs.length
      while !bingo && j < bingo_boards.length
        bingo = bingo_boards[j].add_number(inputs[i])
        j += 1
      end
      i += 1
      j = 0
    end
    puts i == inputs.length ? 0 : inputs[i - 1] * bingo_boards[j - 1].get_unmarked_sum
  end
end

foo = BingoGame.new('4-dec/resources/test 2/boards', '4-dec/resources/test 2/number-input')
