# frozen_string_literal: true

# Class containing functionality for Day10
class SyntaxFixer
  def brackets
    {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }
  end

  def scores
    {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25_137
    }
  end

  def ac_scores
    {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }
  end

  def corrupted?(line)
    char_stack = []
    corrupt = false
    line.each_char do |c|
      if brackets.keys.include?(c)
        char_stack.append(c)
      elsif brackets.values.include?(c)
        c == brackets[char_stack.last] ? char_stack.pop : corrupt = true
      end
    end
    corrupt
  end

  def get_corrupted_char(line)
    char_stack = []
    line.each_char do |c|
      if brackets.keys.include?(c)
        char_stack.append(c)
      elsif brackets.values.include?(c)
        c == brackets[char_stack.last] ? char_stack.pop : (return c)
      end
    end
  end

  def autocomplete(line)
    char_stack = []
    line.each_char do |c|
      if brackets.keys.include?(c)
        char_stack.append(c)
      elsif brackets.values.include?(c)
        char_stack.pop if c == brackets[char_stack.last]
      end
    end
    char_stack.reverse.map { |c| brackets[c] }
  end

  def fix_incomplete(file)
    all_scores = []
    missing_chars = File.readlines(file).map(&:strip).reject { |l| corrupted?(l) }.map { |l| autocomplete(l) }
    missing_chars.each do |line|
      score = 0
      line.each { |char| score = (5 * score) + ac_scores[char] }
      all_scores.append(score)
    end
    all_scores.sort[(all_scores.length - 1) / 2]
  end

  def count_currupted_score(file)
    File.readlines(file).map(&:strip).map { |line| get_corrupted_char(line) }.map { |s| scores[s] }.compact.sum
  end
end

sf = SyntaxFixer.new
# puts sf.count_currupted_score('10-dec/resources/test/input')
puts sf.fix_incomplete('10-dec/resources/puzzle/input')
