export build_wire_coordinates, get_minimum_intersection_distance


function build_wire_coordinates(wire_directions)
    path = []
    current_x = 0
    current_y = 0
    dx = Dict('L'=> -1, 'R'=> 1, 'U'=> 0, 'D'=> 0)
    dy = Dict('L'=> 0, 'R'=> 0, 'U'=> 1, 'D'=> -1)
    for direction_instruction in wire_directions
        direction = direction_instruction[1]
        count = parse(Int, direction_instruction[2:end])
        step_x = dx[direction]
        step_y = dy[direction]
        for _ = 1:count
            current_x += step_x
            current_y += step_y
            push!(path, (current_x, current_y))
        end
    end
    return path
end

function get_minimum_intersection_distance(intersections)
    minimum_distance = nothing
    for row in eachrow(intersections)
        distance = sum(abs.(row[1]))
        if isnothing(minimum_distance) || minimum_distance > distance
            minimum_distance = distance
        end
    end
    return minimum_distance
end

d03_inputpath = joinpath(@__DIR__, "input.txt")
d03_inputread(path) = readdlm(path, ',')

function d03_answer1(input)
    coords1 = build_wire_coordinates(input[1, :])
    coords2 = build_wire_coordinates(input[2, :])
    intersections = intersect(coords1, coords2)
    return get_minimum_intersection_distance(intersections)
end

function d03_answer2(input)
    return 0
end
