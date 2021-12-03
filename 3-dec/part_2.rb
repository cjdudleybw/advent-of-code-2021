# frozen_string_literal: true

def read_input(file)
  File.readlines(file).map(&:strip).map(&:chars).map { |a| a.map(&:to_i) }
end

def get_most_common_index(index_array)
  a = 1
  index_array.each { |i| i.positive? ? a += 1 : a -= 1 }
  a.positive? ? 1 : 0
end

def get_least_common_index(index_array)
  a = 1
  index_array.each { |i| i.positive? ? a += 1 : a -= 1 }
  a.positive? ? 0 : 1
end

def get_ogr(array)
  i = 0
  while i < array[0].length && array.length > 1
    most_freq = get_most_common_index(array.map { |a| a[i] })
    array = array.filter { |n| n[i] == most_freq }
    i += 1
  end
  array.join.to_s.to_i(2)
end

def get_co2(array)
  i = 0
  while i < array[0].length && array.length > 1
    least_freq = get_least_common_index(array.map { |a| a[i] })
    array = array.filter { |n| n[i] == least_freq }
    i += 1
  end
  array.join.to_s.to_i(2)
end

input_array = read_input('3-dec/resources/input-1')
puts get_ogr(input_array) * get_co2(input_array)
