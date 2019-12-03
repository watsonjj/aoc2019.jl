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

end # module
