# frozen_string_literal: true

def run_day(school)
  new_gen = school[0]
  1.upto(8).each { |age| school[age - 1] = school[age] }
  school[8] = new_gen
  school[6] += new_gen
  school
end

def run_lantern_sim(file, days)
  school = Hash.new(0)
  File.foreach(file).first.split(',').map(&:to_i).each { |age| school[age] += 1 }
  1.upto(days).each { school = run_day(school) }
  puts school.values.sum
end

run_lantern_sim('6-dec/resources/puzzle/input', 256)
