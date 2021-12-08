# frozen_string_literal: true

def sum_n(n)
  n * (n + 1) / 2
end

def calculate_total_fuel(crab_pos, target)
  total_fuel = 0
  crab_pos.each do |pos|
    total_fuel += sum_n((pos[0] - target).abs) * pos[1]
  end
  total_fuel
end

def align_sim(file)
  crab_pos = Hash.new(0)
  File.foreach(file).first.split(',').map(&:to_i).each { |pos| crab_pos[pos] += 1 }
  crab_pos.min[0].upto(crab_pos.max[0]).map { |pos| calculate_total_fuel(crab_pos, pos) }.min
end

puts align_sim('7-dec/resources/puzzle/input')
