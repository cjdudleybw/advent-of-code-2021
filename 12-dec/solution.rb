# frozen_string_literal: true

class Cave
  def initialize(name)
    @name = name
    @size = name =~ /[A-Z]/ ? 'big' : 'small'
    @terminal = %w[start end].include?(name)
    @adjacent = []
  end

  attr_reader :adjacent, :name, :size, :terminal

  def add_adjacent(cave)
    @adjacent.append(cave)
  end
end

def can_visit_cave(route, cave)
  if cave.size == 'big' || cave.name == 'end'
    true
  elsif cave.name == 'start'
    false
  else
    caves = Hash.new(0)
    lower = route.reject do |seen_cave|
      seen_cave.size == 'big' || seen_cave.terminal
    end
    lower.each { |seen_cave| caves[seen_cave.name] += 1 }
    caves.values.include?(2) ? caves[cave.name] == 0 : true
  end
end

def traverse(all_routes, past_route, cave)
  curr_route = past_route.clone
  curr_route.append(cave)
  if cave.name == 'end'
    all_routes.append(curr_route)
  else
    cave.adjacent.each do |next_cave|
      traverse(all_routes, curr_route, next_cave) if can_visit_cave(curr_route, next_cave)
    end
  end
end

def get_paths(file)
  caves = Hash.new(0)
  File.readlines(file).map(&:strip).map { |line| line.split('-') }.each do |pair|
    pair.each { |cave| caves[cave] = Cave.new(cave) if caves[cave] == 0 }
    caves[pair[0]].add_adjacent(caves[pair[1]])
    caves[pair[1]].add_adjacent(caves[pair[0]])
  end

  all_routes = []
  curr_route = []
  traverse(all_routes, curr_route, caves['start'])
  all_routes
end

puts get_paths('12-dec/resources/puzzle/input').length
