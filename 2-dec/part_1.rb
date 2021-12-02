# frozen_string_literal: true

def compile_navigation(file)
  depth = 0
  horizontal = 0

  File.readlines(file).map(&:split).map { |a, b| [a, b.to_i] }.each do |input|
    case input[0]
    when 'down'
      depth += input[1]
    when 'up'
      depth -= input[1]
    when 'forward'
      horizontal += input[1]
    end
  end
  depth * horizontal
end

puts compile_navigation('2-dec/resources/nav-input-1')
