max_r = 12
max_g = 13
max_b = 14
lines = open("2/input.txt") do file
    [replace(l, r"Game \d+: " => "") for l in eachline(file)]
end

# Part 1
sum = Ref(0)
for (k,l) in enumerate(lines)
    reds = [parse(Int, m[1]) for m in eachmatch(r"(\d+)\s+red", l)]
    greens = [parse(Int, m[1]) for m in eachmatch(r"(\d+)\s+green", l)]
    blues = [parse(Int, m[1]) for m in eachmatch(r"(\d+)\s+blue", l)]
    if all(i -> i ≤ max_r, reds) && all(i -> i ≤ max_g, greens) && all(i -> i ≤ max_b, blues)
        sum[] += k
    end
end
println("Part 1: ", sum[])

# Part 2
sum_power = Ref(0)
for (k,l) in enumerate(lines)
    red = maximum([parse(Int, m[1]) for m in eachmatch(r"(\d+)\s+red", l)])
    green = maximum([parse(Int, m[1]) for m in eachmatch(r"(\d+)\s+green", l)])
    blue = maximum([parse(Int, m[1]) for m in eachmatch(r"(\d+)\s+blue", l)])
    sum_power[] += red * green * blue
end
println("Part 2: ", sum_power[])
