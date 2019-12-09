using DelimitedFiles

export juliaify_address, process_intcode!, elf_intcode_input!, determine_elf_intcode_inputs

juliaify_address(address::Int) = address + 1

function process_intcode!(intcode::Vector{Int})
    instruction_pointer = juliaify_address(0)
    while true
        opcode = intcode[instruction_pointer]
        if opcode == 99
            return
        elseif opcode == 1
            inputaddr1 = juliaify_address(intcode[instruction_pointer + 1])
            inputaddr2 = juliaify_address(intcode[instruction_pointer + 2])
            outputaddr = juliaify_address(intcode[instruction_pointer + 3])
            intcode[outputaddr] = intcode[inputaddr1] + intcode[inputaddr2]
            instruction_pointer += 4
        elseif opcode == 2
            inputaddr1 = juliaify_address(intcode[instruction_pointer + 1])
            inputaddr2 = juliaify_address(intcode[instruction_pointer + 2])
            outputaddr = juliaify_address(intcode[instruction_pointer + 3])
            intcode[outputaddr] = intcode[inputaddr1] * intcode[inputaddr2]
            instruction_pointer += 4
        else
            throw(ArgumentError("Unexpected optcode: $opcode"))
        end
    end
end

elf_intcode_input!(intcode, index, fix) = intcode[index+1] = fix

function determine_elf_intcode_inputs(intcode, result)
    for position1 = 0:99
        for position2 = 0:99
            intcode_ = copy(intcode)
            elf_intcode_input!(intcode_, 1, position1)
            elf_intcode_input!(intcode_, 2, position2)
            process_intcode!(intcode_)
            if intcode_[1] == result
                return position1, position2
            end
        end
    end
end

d02_inputpath = joinpath(@__DIR__, "input.txt")
d02_inputread(path) = vec(readdlm(path, ',', Int))

function d02_answer1(input)
    input = copy(input)
    elf_intcode_input!(input, 1, 12)
    elf_intcode_input!(input, 2, 2)
    process_intcode!(input)
    return input[1]
end

function d02_answer2(input)
    noun, verb = determine_elf_intcode_inputs(input, 19690720)
    return 100 * noun + verb
end
