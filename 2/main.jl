max_r = 12
max_g = 13
max_b = 14
lines = open("2/input.txt") do file
    [replace(l, r"Game \d+: " => "") for l in eachline(file)]
end

sum = Ref(0)
for (k,l) in enumerate(lines)
    reds = [parse(Int, match(r"\d+", m.match).match) for m in eachmatch(r"\d+\s+red", l)]
    greens = [parse(Int, match(r"\d+", m.match).match) for m in eachmatch(r"\d+\s+green", l)]
    blues = [parse(Int, match(r"\d+", m.match).match) for m in eachmatch(r"\d+\s+blue", l)]
    if all(i -> i ≤ max_r, reds) && all(i -> i ≤ max_g, greens) && all(i -> i ≤ max_b, blues)
        sum[] += k
    end
end
println(sum[])
