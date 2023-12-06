lines = open("6/input.txt") do file 
    [[parse(Int,m.match) for m in eachmatch(r"\d+", l)] for l in eachline(file)]
end

# distance = time remaining * speed, time remaining = time - speed
# distance = -speed^2 + time*speed
# speed in 0:1:time
# possible distances obtained by replacing by possible speeds

# Part 1
const n_races = length(lines[1])
total = Ref(1)
for i in 1:n_races
    race_tot = 0
    time = lines[1][i]
    record = lines[2][i]
    for speed in 0:time
        (-speed^2 + time*speed > record) && (race_tot += 1)
    end
    total[] *= race_tot
end
println("Part 1: $(total[])") # 2344708

# Part 2
t = parse(Int,join([string(i) for i in lines[1]]))
d = parse(Int,join([string(i) for i in lines[2]]))
# wining distances are distances -speed^2 + t*speed > d : trinome in speed 
# ok when delta = t^2 -4*d > 0 <=> time > 2 sqrt(d)
@assert t > 2*sqrt(d)
# then the solutions are integers values between x1 = (t-sqrt(delta))/2 and x2 = (t -sqrt(delta)) /2
delta = t^2 - 4*d
x1 = ceil((t - sqrt(delta))/2)
x2 = floor((t + sqrt(delta))/2)
tot = Int(x2 - x1)
