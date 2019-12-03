module aoc2019

using BenchmarkTools
import DataFrames: DataFrame
import Dates

export get_answer, print_day_answer, print_all_answers

answerfuncs = Dict{Int, Tuple{Function, Function}}()
inputreads = Dict{Int, Function}()
inputpaths = Dict{Int, String}()

for day = 1:25
    day_string = "d$(lpad(string(day), 2, "0"))"
    file = "$day_string/$day_string.jl"
    if isfile(joinpath(@__DIR__, file))
        include(file)
        funcs = ()
        answerfuncs[day] = (
            getfield(aoc2019, Symbol("$(day_string)_answer1")),
            getfield(aoc2019, Symbol("$(day_string)_answer2"))
        )
        inputreads[day] = getfield(aoc2019, Symbol("$(day_string)_inputread"))
        inputpaths[day] = getfield(aoc2019, Symbol("$(day_string)_inputpath"))
    end
end

function get_answers(; benchmark=false)
    df = DataFrame(
        day = Int[],
        answer1 = String[],
        answer2 = String[],
        benchmarki = String[],
        benchmark1 = String[],
        benchmark2 = String[],
    )
    for (day, (answer1func, answer2func)) in answerfuncs
        inputread = inputreads[day]
        inputpath = inputpaths[day]
        input = inputread(inputpath)
        if benchmark
            benchmarki = @belapsed($inputread($inputpath))
            benchmark1 = @belapsed($answer1func($input))
            benchmark2 = @belapsed($answer2func($input))
        else
            benchmarki = NaN
            benchmark1 = NaN
            benchmark2 = NaN
        end
        push!(df, Dict(
            :day=>day,
            :answer1=>string(answer1func(input)),
            :answer2=>string(answer2func(input)),
            :benchmarki=>BenchmarkTools.prettytime(1e9 * benchmarki),
            :benchmark1=>BenchmarkTools.prettytime(1e9 * benchmark1),
            :benchmark2=>BenchmarkTools.prettytime(1e9 * benchmark2),
        ))
    end
    df
end



# function get_answer(day::Int, part::Int)
#     func = answers[day, part]
#     input = inputs[day, part]
#     func(input)
# end
#
# function print_day_answer(day::Int)
#     answer1 = get_answer(day, 1)
#     answer2 = get_answer(day, 2)
#     day_string = "d$(lpad(string(day), 2, "0"))"
#     println("Day: $day_string, Answer1: $answer1, Answer2: $answer2")
# end
#
# function print_all_answers()
#     for day in days
#         print_day_answer(day)
#     end
# end
#
# formatTime(t) = BenchmarkTools.prettytime(1e9 * t)
#
# function benchmark()
#     df = DataFrame(part1 = String[], part2 = String[])
#     for day in days
#
#         m = getproperty(@__MODULE__, Symbol("day$day"))
#         t1 = onlyOnce ? @elapsed(m.part1((m.input))) : @belapsed($m.part1($(m.input)))
#         t2 = onlyOnce ? @elapsed(m.part2((m.input))) : @belapsed($m.part2($(m.input)))
#         push!(df, formatTime.((t1, t2)))
#     end
#     df
# end

end # module
