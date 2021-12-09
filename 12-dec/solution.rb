# frozen_string_literal: true

segment_map = {
    1z
}

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
  counts = {}
  (line[0] + line[1]).each do |out|
    counts[len_to_num(out.length)] = out if [2, 3, 4, 7].include? out.length
  end
  counts
end

def get_instances(file)
  line_solves = []
  File.readlines(file).map { |l| l.split('|') }.map { |a, b,| [a.split, b.split] }.each do |line|
    line_solves.append(solve_line(line))
  end
  line_solves
end

puts get_instances('8-dec/resources/test/input-small').to_a.map(&:inspect)
