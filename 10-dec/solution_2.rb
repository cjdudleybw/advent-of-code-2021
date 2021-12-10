# frozen_string_literal: true

def find_incomplete(line)
  brackets = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
  stack = []
  line.each_char do |c|
    stack.append(c) if brackets.keys.include?(c)
    (c == brackets[stack.last] ? stack.pop : (return [])) if brackets.values.include?(c)
  end
  stack.map { |c| brackets[c] }.reverse
end

def autocomplete_score(file)
  scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
  lines_to_score = File.readlines(file).map { |l| find_incomplete(l) }.select(&:any?)
  all_scores = lines_to_score.map { |line| line.inject(0) { |score, char| (5 * score) + scores[char] } }
  all_scores.sort[(all_scores.length - 1) / 2]
end

puts autocomplete_score('10-dec/resources/puzzle/input')
