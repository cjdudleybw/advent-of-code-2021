
def getIncreaseDepthcount(window, file)
    File.readlines(file).map(&:to_i).each_cons(window).map(&:sum).each_cons(2).map {|a,b| b>a ? 1:0}.sum
end

puts getIncreaseDepthcount(3, "1-dec/resources/depth-input-2")