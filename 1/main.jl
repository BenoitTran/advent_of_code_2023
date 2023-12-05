### Loading data
file = open("1/input.txt", "r")
words = [line for line in eachline(file)]
close(file)

function add!(sum::Ref{Int}, word::String)
    di = parse.(Int, [m.match for m in eachmatch(r"\d", word)]) 
    sum[] += 10*di[1] + di[end] 
end
function add!(sum::Ref{Int}, word::String, pattern::Regex)
    matches = [get(word_digits, m.match, m.match) for m in eachmatch(pattern, word, overlap=true)]
    di = parse.(Int, matches) 
    println(word, " ", matches, " ", 10*di[1] + di[end])
    sum[] += 10*di[1] + di[end] 
end

### PART 1 script
sum = Ref(0)
for w in words
    add!(sum, w)
end
println("Part 1: ", sum[])

## PART 2
word_digits = Dict("one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9")
pattern = Regex( join(keys(word_digits), "|") * "|" *join(values(word_digits), "|") )
sum = Ref(0)
for w in words
    add!(sum, w, pattern)
end
println("Part 2: ", sum[])




