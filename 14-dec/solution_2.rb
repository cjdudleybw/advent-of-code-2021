# frozen_string_literal: true

def pair_insert(pair, new_char)
  pair.chars.insert(1, new_char).each_cons(2).to_a.map(&:join)
end

def get_elem_diff(elems, poly_template)
  elems[poly_template.first] -= - 1
  elems[poly_template.last] -=  - 1
  (elems.max_by { |_k, v| v }[1] - elems.min_by { |_k, v| v }[1]) / 2
end

def do_step(pair_counts, insertions)
  new_pair_counts = Hash.new(0)
  pair_counts.each do |k, v|
    insertions[k].each { |pair| new_pair_counts[pair] += v }
  end
  new_pair_counts
end

def elem_counts(pair_counts)
  elem_counts = Hash.new(0)
  pair_counts.each { |k, v| k.chars.each { |c| elem_counts[c] += v } }
  elem_counts
end

def insertions(all_lines)
  Hash[all_lines.drop(2).map { |line| line.split(' -> ') }.map { |k, v| [k, pair_insert(k, v)] }]
end

def solution(file, steps)
  all_lines = File.readlines(file).map(&:strip)
  pair_counts = Hash.new(0)
  all_lines[0].chars.each_cons(2).each { |pair| pair_counts[pair.join] += 1 }
  insertions = insertions(all_lines)

  steps.times do
    pair_counts = do_step(pair_counts, insertions)
  end
  get_elem_diff(elem_counts(pair_counts), all_lines[0].chars)
end

puts solution('14-dec/resources/puzzle/input', 40)
