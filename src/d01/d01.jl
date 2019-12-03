using DelimitedFiles

export fuel_required, fuel_required_including_fuel

fuel_required(mass) = clamp(mass ÷ 3 - 2, 0, typemax(Int))

function fuel_required_including_fuel(mass)
    fuel = fuel_required(mass)
    fuel == 0 ? 0 : fuel + fuel_required_including_fuel(fuel)
end

d01_inputpath = joinpath(@__DIR__, "input.txt")
d01_inputread(path) = vec(readdlm(path, '\n', Int))
d01_answer1(input) = sum(fuel_required, input)
d01_answer2(input) = sum(fuel_required_including_fuel, input)
