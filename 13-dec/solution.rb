# frozen_string_literal: true

require 'pp'

def do_fold(dots, fold)
  dots.keys.each do |dot|
    case fold[0]
    when 'x'
      if dot[0] > fold[1].to_i
        dots.delete(dot)
        dot[0] = dot[0] - 2 * (dot[0] - fold[1].to_i)
        dots[dot] = true
      end
    when 'y'
      if dot[1] > fold[1].to_i
        dots.delete(dot)
        dot[1] = dot[1] - 2 * (dot[1] - fold[1].to_i)
        dots[dot] = true
      end
    end
  end
end

def pretty_print_dots(dots)
  h = dots.keys.map { |k| k[0] }.max
  w = dots.keys.map { |k| k[1] }.max
  grid = Array.new(h + 1) { Array.new(w + 1, '.') }
  dots.each_key do |dot|
    grid[dot[0]][dot[1]] = '#'
  end
  pp grid
end

def solution(file)
  all_lines = File.readlines(file).map(&:strip).reject(&:empty?)
  dots = {}
  all_lines.reject do |line|
    line.include?('fold')
  end.map { |line| line.split(',') }.map { |coord| coord.map(&:to_i) }.each do |dot|
    dots[dot] =
      true
  end
  folds = all_lines.select do |line|
            line.include?('fold')
          end.map { |fold| fold.match(/[xy]=[0-9]*/)[0] }.map { |line| line.split('=') }

  folds.each { |fold| do_fold(dots, fold) }
  dots
end

pretty_print_dots(solution('13-dec/resources/puzzle/input'))
