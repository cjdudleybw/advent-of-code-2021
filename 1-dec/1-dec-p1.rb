
filename = "1-dec/resources/depth-input"
increaseCount = 0
previous = -1

File.readlines(filename).each do |line|
    if line.to_i > previous and previous >= 0
        increaseCount += 1
    end
    previous = line.to_i
end

puts increaseCount
