# frozen_string_literal: true

# 0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....
#
#  5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

def init_solve_map
  {
    'a' => [],
    'b' => [],
    'c' => [],
    'd' => [],
    'e' => [],
    'f' => [],
    'g' => []
  }
end

def len_to_num(len)
  case len
  when 2
    1
  when 4
    4
  when 3
    7
  when 7
    8
  end
end

def solve_line(line)
  segment_map = {
    0 => %w[a b c e f g],
    1 => %w[c f],
    2 => %w[a c d e g],
    3 => %w[a c d f g],
    4 => %w[b c d f],
    5 => %w[a b d f g],
    6 => %w[a b d e f g],
    7 => %w[a c f],
    8 => %w[a b c d e f g],
    9 => %w[a b c d f g]
  }
  solve_map = init_solve_map
  counts = {}
  all_nums = line[0] + line[1]
  all_nums.each do |out|
    counts[len_to_num(out.length)] = out if [2, 3, 4, 7].include? out.length
  end
  solve_map['a'] = counts[7].chars - counts[1].chars
  solve_map['c'] = counts[1].chars
  solve_map['f'] = counts[1].chars
  solve_map['e'] = counts[8].chars - counts[4].chars - counts[7].chars
  solve_map['g'] = counts[8].chars - counts[4].chars - counts[7].chars
  solve_map['b'] = counts[4].chars - counts[1].chars
  solve_map['d'] = counts[4].chars - counts[1].chars

  cand_2 = all_nums.select { |num| num.length == 5 && (solve_map['e'] - num.chars).empty? }.first
  solve_map['d'] = solve_map['d'].select { |c| cand_2.chars.include? c }
  solve_map['b'] = solve_map['b'].reject { |c| cand_2.chars.include? c }

  cand_6 = all_nums.select { |num| num.length == 6 && !(solve_map['c'] - num.chars).empty? }.first
  solve_map['f'] = solve_map['f'].select { |c| cand_6.chars.include? c }
  solve_map['c'] = solve_map['c'].reject { |c| cand_6.chars.include? c }

  cand_9 = all_nums.select { |num| num.length == 6 && !(solve_map['e'] - num.chars).empty? }.first
  solve_map['g'] = solve_map['g'].select { |c| cand_9.chars.include? c }
  solve_map['e'] = solve_map['e'].reject { |c| cand_9.chars.include? c }

  line[1].map { |num| num.chars.map { |c| solve_map.key([c]) }.join }.map { |tnum| segment_map.key(tnum.chars.sort) }.join
end

def get_instances(file)
  line_solves = 0
  File.readlines(file).map { |l| l.split('|') }.map { |a, b,| [a.split, b.split] }.each do |line|
    line_solves += solve_line(line).to_i
  end
  puts line_solves
end

get_instances('8-dec/resources/puzzle/input').to_a.map(&:inspect)
