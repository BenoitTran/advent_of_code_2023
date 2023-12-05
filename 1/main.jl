### Loading data
words = open("1/input.txt") do file
    [l for l in eachline(file)]
end
word_digits = Dict("one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9")

function add!(sum::Ref{Int}, word::String; pattern::Regex = r"\d", dict::Dict{String, String} = word_digits)
    matches = [get(dict, m.match, m.match) for m in eachmatch(pattern, word, overlap=true)]
    di = parse.(Int, matches) 
    sum[] += 10*di[1] + di[end] 
end

### PART 1 script
sum = Ref(0)
for w in words
    add!(sum, w)
end
println("Part 1: ", sum[])

## PART 2
sum = Ref(0)
for w in words
    add!(sum, w; pattern = Regex( join(keys(word_digits), "|") * "|" *join(values(word_digits), "|") ))
end
println("Part 2: ", sum[])
