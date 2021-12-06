# frozen_string_literal: true

def h_lines(start_p, end_p)
  points = []
  x_range = [start_p[0], end_p[0]].sort
  x_range[0].upto(x_range[1]).each do |x|
    points.append([x, start_p[1]].join(','))
  end
  points
end

def v_lines(start_p, end_p)
  points = []
  y_range = [start_p[1], end_p[1]].sort
  y_range[0].upto(y_range[1]).each do |y|
    points.append([start_p[0], y].join(','))
  end
  points
end

def d_lines(start_p, end_p)
  # puts "#{start_p} -> #{end_p}"
  x_range = start_p[0] > end_p[0] ? (end_p[0]..start_p[0]).to_a.reverse : (start_p[0]..end_p[0]).to_a
  y_range = start_p[1] > end_p[1] ? (end_p[1]..start_p[1]).to_a.reverse : (start_p[1]..end_p[1]).to_a
  # puts "x_range = #{x_range}"
  # puts "y_range = #{y_range}"
  x_range.zip(y_range).map { |p| p.join(',') }
end

def expand_line(line)
  points = []
  start_p = line[0].split(',').map(&:to_i)
  end_p = line[1].split(',').map(&:to_i)

  if start_p[0] == end_p[0]
    v_lines(start_p, end_p).each { |p| points.append(p) }
  elsif start_p[1] == end_p[1]
    h_lines(start_p, end_p).each { |p| points.append(p) }
  else
    d_lines(start_p, end_p).each { |p| points.append(p) }
  end
  points
end

def map_vents(file)
  ocean_floor_map = Hash.new(0)
  ocean_floor_map.default = 0
  vent_lines = File.readlines(file).map { |line| line.strip.split(' -> ') }.map { |line| expand_line(line) }
  # puts vent_lines.to_a.map(&:inspect)
  vent_lines.each do |vl|
    vl.each do |point|
      ocean_floor_map[point] += 1
    end
  end
  # puts ocean_floor_map
  ocean_floor_map.count { |point| point[1] >= 2 }
end

puts map_vents('5-dec/resources/puzzle/input')
