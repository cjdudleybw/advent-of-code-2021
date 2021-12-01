# frozen_string_literal: true

def get_increase_count(file)
  File.readlines(file).map(&:to_i).each_cons(2).map { |a, b| b > a ? 1 : 0 }.sum
end

puts get_increase_count('1-dec/resources/depth-input-2')
