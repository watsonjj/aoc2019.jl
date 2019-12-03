using DelimitedFiles

export fuel_required

fuel_required(module_mass) = module_mass ÷ 3 - 2

d01_inputpath = joinpath(@__DIR__, "input.txt")
d01_inputread(path) = vec(readdlm(path, '\n', Int))
d01_answer1(input) = sum(fuel_required, input)
d01_answer2(input) = NaN
