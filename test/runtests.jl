using Test, DataFrames, aoc2019

@testset "base" begin
    @test length(aoc2019.answerfuncs) > 0
    @test length(aoc2019.answerfuncs) == length(aoc2019.inputreads)
    @test length(aoc2019.answerfuncs) == length(aoc2019.inputpaths)
    @test aoc2019.get_answers() isa DataFrames.DataFrame
end

include("d01.jl")
include("d02.jl")
include("d03.jl")
