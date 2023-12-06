
lines = open("4/input.txt") do file 
    [split(replace(l, r"Card\s+\d+: " => ""),"|") for l in eachline(file)]
end
function n_wins(line::Vector{SubString{String}})
    inputs = Dict(key => 1 for key in [m.match for m in eachmatch(r"\d+", line[1])])
    outputs = [m.match for m in eachmatch(r"\d+", line[2])]
    wins = 0
    for i in outputs
        wins += haskey(inputs, i)
    end
    return wins
end

# Part 1
score = Ref(0)
for l in lines
    n_w = n_wins(l)
    (n_w > 0) && (score[] += 2^(n_w-1))
end
println("Part 1: $(score[])") # 21105

# Part 2
const n_lines = length(lines)
total = Ref(0)
n_cards = Dict(key => 1 for key in 1:n_lines)
for (k,l) in enumerate(lines)
    total[] += n_cards[k]
    wins = n_wins(l)
    n_w = n_cards[k]*wins
    for i in k+1:k+wins
        n_cards[i] += n_cards[k]
    end
end
println("Part 2: $(total[])") # 5329815
