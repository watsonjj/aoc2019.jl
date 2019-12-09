using Test, aoc2019


@testset "juliaify_address" begin
    @test juliaify_address(1) == 2
end

@testset "process_intcode" begin
    (intcode = [1,9,10,3,2,3,11,0,99,30,40,50]; process_intcode!(intcode))
    @test intcode == [3500,9,10,70,2,3,11,0,99,30,40,50]

    (intcode = [1,0,0,0,99]; process_intcode!(intcode))
    @test intcode == [2,0,0,0,99]

    (intcode = [2,3,0,3,99]; process_intcode!(intcode))
    @test intcode == [2,3,0,6,99]

    (intcode = [2,4,4,5,99,0]; process_intcode!(intcode))
    @test intcode == [2,4,4,5,99,9801]

    (intcode = [1,1,1,4,99,5,6,0,99]; process_intcode!(intcode))
    @test intcode == [30,1,1,4,2,5,6,0,99]

    @test_throws BoundsError process_intcode!([1,0,0,0])
    @test_throws BoundsError process_intcode!([1,0,0,0,1])
    @test_throws BoundsError process_intcode!([1,0,0,10,99])
    @test_throws ArgumentError process_intcode!([3,0,0,0,1,2,2,3])
end

@testset "elf_intcode_input" begin
    (intcode = [1,9,10,3,2]; index=0; fix=2; elf_intcode_input!(intcode, index, fix))
    @test intcode == [2,9,10,3,2]
end

@testset "determine_elf_intcode_inputs" begin
    intcode = aoc2019.d02_inputread(aoc2019.d02_inputpath)
    @test determine_elf_intcode_inputs(intcode, 4690667) == (12, 2)
end

@testset "d02_answers" begin
    @test aoc2019.d02_inputpath isa String
    input = aoc2019.d02_inputread(aoc2019.d02_inputpath)
    @test length(input) == 173
    @test aoc2019.d02_answer1(input) == 4690667
    @test aoc2019.d02_answer2(input) == 6255
end
