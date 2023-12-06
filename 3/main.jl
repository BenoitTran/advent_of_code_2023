


lines = open("3/input.txt") do file
    [l for l in eachline(file)]
end
const width = length(lines[1])
const height = length(lines)

struct Num
    val::Int
    l::Int
    m::Int
    M::Int
end

struct Star
    l::Int
    i::Int
end

function issymbol(char::Char)
    return !isnumeric(char) && char != '.'
end

function isadjacent(n::Num; lines = lines)
    n.l > 1 ? up = !all(x -> !issymbol(x), lines[n.l-1][n.m:n.M]) : up = false
    mid = issymbol(lines[n.l][n.m]) || issymbol(lines[n.l][n.M])
    n.l < length(lines) ? down = !all(x -> !issymbol(x), lines[n.l+1][n.m:n.M]) : down = false
    return up || mid || down
end

function issandwiched(s::Star; lines = lines)
    prod = 1
    nums = 0
    # Can have up to two numbers top
    if s.l > 1
        if isnumeric(lines[s.l-1][s.i])
            nums += 1
            prod *= find_number(lines[s.l-1], s.i)
        elseif isnumeric(lines[s.l-1][s.i-1]) && isnumeric(lines[s.l-1][s.i+1])
            prod *= find_number(lines[s.l-1], s.i-1)
            prod *= find_number(lines[s.l-1], s.i+1)
            return (bool = true, prod = prod)
        elseif isnumeric(lines[s.l-1][s.i-1])
            nums += 1
            prod *= find_number(lines[s.l-1], s.i-1)
        elseif isnumeric(lines[s.l-1][s.i+1])
            nums += 1
            prod *= find_number(lines[s.l-1], s.i+1)
        end
    end
    # checking left
    if (s.i > 1) && isnumeric(lines[s.l][s.i-1])
        prod *= find_number(lines[s.l], s.i-1)
        nums += 1
    end
    # checking right
    if (s.i < width) && isnumeric(lines[s.l][s.i+1])
        prod *= find_number(lines[s.l], s.i+1)
        nums += 1
    end
    # checking bot
    if s.l < height
        if isnumeric(lines[s.l+1][s.i])
            prod *= find_number(lines[s.l+1], s.i)
            nums += 1
        elseif isnumeric(lines[s.l+1][s.i-1]) && isnumeric(lines[s.l+1][s.i+1])
            prod *= find_number(lines[s.l+1], s.i-1)
            prod *= find_number(lines[s.l+1], s.i+1)
            return (bool = true, prod = prod)
        elseif isnumeric(lines[s.l+1][s.i-1])
            prod *= find_number(lines[s.l+1], s.i-1)
            nums +=1
        elseif isnumeric(lines[s.l+1][s.i+1])
            nums +=1
            prod *= find_number(lines[s.l+1], s.i+1)
        end
    end
    return (bool = (nums==2), prod = prod)
end

function find_number(line::String, i::Int)
    ## Test full left then move right when meeting '.' or wall
    if (i>1) && isnumeric(line[i-1])
        if (i>2) && isnumeric(line[i-2])
            return parse(Int, line[i-2:i])
        elseif (i<width) && isnumeric(line[i+1])
            return parse(Int, line[i-1:i+1])
        else 
            return parse(Int, line[i-1:i])
        end
    elseif (i<width) && isnumeric(line[i+1])
        if (i<width-1) && isnumeric(line[i+2])
            return parse(Int, line[i:i+2])
        else 
            return parse(Int, line[i:i+1])
        end
    else
        return parse(Int, line[i])
    end
end

# Part 1
## Find each numbers w, with corresponding # line and positions of both the left-1 and right+1 chars (without the 1 shift if doesn't exist)
numbers = []
for (k,l) in enumerate(lines)
    zz = zip(eachmatch(r"(\d+)",l), findall(r"\d+", l))
    append!(numbers, [Num(parse(Int,m.match), k, max(1,minimum(ind)-1), min(maximum(ind)+1, width)) for (m,ind) in zz] )
end
@time begin
    seum = Ref(0)
    for n in numbers 
        isadjacent(n) && (seum[] += n.val)
    end
    println("Part 1: $(seum[])") # 550934
end

# Part 2
stars = []
for (k,l) in enumerate(lines)
    append!(stars, Star(k,minimum(ind))  for ind in findall(r"\*", l) )
end
@time begin
    sum2 = Ref(0)
    for star in stars
        out = issandwiched(star)
        out.bool && (sum2[] += out.prod)
    end
    println("Part 2: $(sum2[])") # 81997870
end

