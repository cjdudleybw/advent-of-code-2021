# frozen_string_literal: true

def get_final_bin(file)
  File.readlines(file).map(&:strip).map(&:chars).map { |a| a.map(&:to_i).map { |b| b == 1 ? 1 : -1 } }
      .transpose.map { |e| e.inject(:+) }.map { |s| s.positive? ? 1 : 0 }
end

bin = get_final_bin('3-dec/resources/test-input')

gamma = bin.join.to_s.to_i(2)
epsilon = bin.map { |d| d.positive? ? 0 : 1 }.join.to_s.to_i(2)

puts gamma * epsilon

