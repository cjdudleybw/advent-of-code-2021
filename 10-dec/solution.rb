# frozen_string_literal: true

def validate_line(line)
  brackets = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }
  char_stack = []
  line.each_char do |c|
    if brackets.keys.include?(c)
      char_stack.append(c)
    elsif brackets.values.include?(c)
      c == brackets[char_stack.last] ? char_stack.pop : (return c)
    end
  end
end

def parse_input_file(file)
  scores = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25_137
  }
  File.readlines(file).map(&:strip).map { |line| validate_line(line) }.map { |s| scores[s] }.compact.sum
end

puts parse_input_file('10-dec/resources/puzzle/input')
