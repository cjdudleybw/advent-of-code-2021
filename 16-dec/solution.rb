# frozen_string_literal: true

@hex_to_bin = {
  '0' => '0000',
  '1' => '0001',
  '2' => '0010',
  '3' => '0011',
  '4' => '0100',
  '5' => '0101',
  '6' => '0110',
  '7' => '0111',
  '8' => '1000',
  '9' => '1001',
  'A' => '1010',
  'B' => '1011',
  'C' => '1100',
  'D' => '1101',
  'E' => '1110',
  'F' => '1111'
}

def parse_literal(stack)
  literal = []
  window = [1]
  while window[0].to_i != 0
    window = stack.shift(5)
    literal << window.drop(1)
  end
  literal.flatten.join.to_i(2)
end

def parse_operator(stack)
  if stack.shift.to_i.zero?
    parse_packet(stack.shift(stack.shift(15).join.to_i(2))).flatten.map(&:to_i)
  else
    1.upto(stack.shift(11).join.to_i(2)).map { parse_packet(stack, true) }.flatten.flatten.map(&:to_i)
  end
end

def parse_packet(stack, counting = false)
  version = stack.shift(3).join.to_i(2)
  type_id = stack.shift(3).join.to_i(2)

  result = []
  case type_id
  when 0
    # sum
    result << parse_operator(stack).sum
  when 1
    # product
    result << parse_operator(stack).inject(:*)
  when 2
    # min
    result << parse_operator(stack).min
  when 3
    # max
    result << parse_operator(stack).max
  when 4
    # parse literal
    result << parse_literal(stack)
  when 5
    # greater
    nums = parse_operator(stack)
    result << (nums[0] > nums[1] ? 1 : 0)
  when 6
    # less
    nums = parse_operator(stack)
    result << (nums[0] < nums[1] ? 1 : 0)
  when 7
    # equal
    nums = parse_operator(stack)
    result << (nums[0] == nums[1] ? 1 : 0)
  end

  result << parse_packet(stack) unless stack.length < 11 || counting
  result
end

def solution(file)
  parse_packet(File.readlines(file).map { |n| n.chars.map { |c| @hex_to_bin[c] }.join }.first.chars)
end

puts solution('16-dec/resources/puzzle/input')
