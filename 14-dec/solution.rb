# frozen_string_literal: true

def pair_insert(pair, new_char)
  pair.chars.insert(1, new_char)
end

def do_step(poly_template, insertions)
  trios = poly_template.each_cons(2).map(&:join).map { |pair| insertions[pair] }
  trios.first.concat(trios.drop(1).map { |trio| trio.drop(1) }).flatten
end

def get_elemend_diff(poly)
  counts = poly.each_with_object(Hash.new(0)) { |key, hash| hash[key] += 1 }
  counts.max_by { |_k, v| v }[1] - counts.min_by { |_k, v| v }[1]
end

def solution(file, steps)
  all_lines = File.readlines(file).map(&:strip)
  poly_template = all_lines[0].chars
  insertions = Hash[all_lines.drop(2).map { |line| line.split(' -> ') }.map { |k, v| [k, pair_insert(k, v)] }]
  steps.times do
    poly_template = do_step(poly_template, insertions)
  end
  get_elemend_diff(poly_template)
end

# puts solution('14-dec/resources/test/input', 10)

x = [4]
40.times do
  x.append(2 * x.last - 1)
end

puts x
# .to_a.map(&:inspect)
