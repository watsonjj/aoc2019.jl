using Test, DataFrames, aoc2019

@testset "base" begin
    @test length(aoc2019.answerfuncs) > 0
    @test length(aoc2019.answerfuncs) == length(aoc2019.inputreads)
    @test length(aoc2019.answerfuncs) == length(aoc2019.inputpaths)
    @test aoc2019.get_answers() isa DataFrames.DataFrame
end

@testset "fuel_required" begin
    @test fuel_required(12) == 2
    @test fuel_required(14) == 2
    @test fuel_required(1969) == 654
    @test fuel_required(100756) == 33583
end

@testset "d01_answers" begin
    @test aoc2019.d01_inputpath isa String
    input = aoc2019.d01_inputread(aoc2019.d01_inputpath)
    @test length(input) == 100
    @test aoc2019.d01_answer1(input) == 3334297
    @test aoc2019.d01_answer2(input) == 3334297
end
