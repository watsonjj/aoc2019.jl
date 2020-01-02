using Test, aoc2019


@testset "build_wire_coordinates" begin
    @test build_wire_coordinates(["L4"]) == [(-1,0),(-2,0),(-3,0),(-4,0)]
    @test build_wire_coordinates(["R4"]) == [(1,0),(2,0),(3,0),(4,0)]
    @test build_wire_coordinates(["U4"]) == [(0,1),(0,2),(0,3),(0,4)]
    @test build_wire_coordinates(["D4"]) == [(0,-1),(0,-2),(0,-3),(0,-4)]
    @test build_wire_coordinates(["R8","U5","L5","D3"]) == [
        (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),
        (8,1),(8,2),(8,3),(8,4),(8,5),
        (7,5),(6,5),(5,5),(4,5),(3,5),
        (3,4),(3,3),(3,2)
    ]
    @test build_wire_coordinates(["U7","R6","D4","L4"]) == [
        (0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),
        (1,7),(2,7),(3,7),(4,7),(5,7),(6,7),
        (6,6),(6,5),(6,4),(6,3),
        (5,3),(4,3),(3,3),(2,3)
    ]
end

@testset "get_intersection_coordinates" begin
    path1 = build_wire_coordinates(["R8","U5","L5","D3"])
    path2 = build_wire_coordinates(["U7","R6","D4","L4"])
    @test intersect(path1, path2) == [(6,5),(3,3)]
end


@testset "get_minimum_intersection_distance" begin
    @test get_minimum_intersection_distance([(6,5),(3,3)]) == 6
end


@testset "d03_chain" begin
    wire1 = ["R75","D30","R83","U83","L12","D49","R71","U7","L72"]
    wire2 = ["U62","R66","U55","R34","D71","R55","D58","R83"]
    coords1 = build_wire_coordinates(wire1)
    coords2 = build_wire_coordinates(wire2)
    intersections = intersect(coords1, coords2)
    @test get_minimum_intersection_distance(intersections) == 159

    wire1 = ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R51"]
    wire2 = ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    coords1 = build_wire_coordinates(wire1)
    coords2 = build_wire_coordinates(wire2)
    intersections = intersect(coords1, coords2)
    @test get_minimum_intersection_distance(intersections) == 135
end

@testset "d03_answers" begin
    @test aoc2019.d03_inputpath isa String
    input = aoc2019.d03_inputread(aoc2019.d03_inputpath)
    @test size(input) == (2, 301)
    @test aoc2019.d03_answer1(input) == 225
    # @test aoc2019.d03_answer2(input) == 6255
end
