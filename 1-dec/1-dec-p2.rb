
filename = "1-dec/resources/depth-input-2"
lines = File.readlines(filename).map(&:to_i)
increaseCount = 0
i = 0

while i + 3 < lines.length

    currentWindow = [lines[i], lines[i+1], lines[i+2]]
    nextWindow = [lines[i+1], lines[i+2], lines[i+3]]

    if nextWindow.sum > currentWindow.sum
        increaseCount += 1
    end
    i += 1
    
end


puts increaseCount
