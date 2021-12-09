using DelimitedFiles

function read_input(filename) 
    digits_data=readdlm(filename, ' ', String)
    digits_data
end

function initial_numfinder(x) 
    detected_number = -1
    
    if (length(x) == 2)
        detected_number = 1
    end

    if (length(x) == 3)
        detected_number = 7
    end

    if (length(x) == 4)
        detected_number = 4
    end

    if (length(x) == 7)
        detected_number = 8
    end

    detected_number
end

function unique_combos(data) 
    combosSet = Set(map(x->join(sort(split(x, "")), ""), data))
    combos = (x->collect.(x)).(combosSet)    
end

function findout_numbers_inputs(input_data)
    input_for_numbers = Array{Vector{Char}}(undef, 10)
    for i in 1:10 
        num = initial_numfinder(input_data[i])
        if num>=0 
            input_for_numbers[num]=input_data[i]
        end
    end

    segmentA = setdiff(Set(input_for_numbers[7]), Set(input_for_numbers[1]))
    input_for_numbers

    union4A = union(input_for_numbers[4], segmentA)
    indexOf9 = findfirst(x->length(intersect(x, union4A))==5 && length(x)==6, input_data)
    input_for_numbers[9] = input_data[indexOf9]

    segmentG = setdiff(input_for_numbers[9], union4A)

    union1AG = union(input_for_numbers[1], segmentA, segmentG)
    indexOf3 = findfirst(x->length(intersect(x, union1AG))==4 && length(x)==5, input_data)
    input_for_numbers[3] = input_data[indexOf3]

    segmentD = setdiff(input_for_numbers[3], union1AG)

    indexOf6 = findfirst(x->length(union(x, input_for_numbers[1]))==7 && length(x)==6, input_data)
    input_for_numbers[6] = input_data[indexOf6]

    indexOf5 = findfirst(x->length(union(x, input_for_numbers[6]))==6 && length(x)==5, input_data)
    input_for_numbers[5] = input_data[indexOf5]

    segmentE = setdiff(input_for_numbers[6], input_for_numbers[5])

    segmentC = setdiff(input_for_numbers[7], input_for_numbers[6])

    segmentF = setdiff(input_for_numbers[1], segmentC)

    indexOf2 = findfirst(x->length(setdiff(x, union(segmentA, segmentC, segmentD, segmentE, segmentG)))==0 && length(x)==5, input_data)
    input_for_numbers[2] = input_data[indexOf2]

    segmentB = setdiff(input_for_numbers[4], union(input_for_numbers[1], segmentD))

    indexOf0 = findfirst(x->length(setdiff(x, union(segmentA, segmentB, segmentC, segmentE, segmentF, segmentG)))==0 && length(x)==6, input_data)
    input_for_numbers[10] = input_data[indexOf0]

    digits = Dict(join(input_for_numbers[10], "") => 0,
    join(input_for_numbers[1], "") => 1,
    join(input_for_numbers[2], "") => 2,
    join(input_for_numbers[3], "") => 3,
    join(input_for_numbers[4], "") => 4,
    join(input_for_numbers[5], "") => 5,
    join(input_for_numbers[6], "") => 6,
    join(input_for_numbers[7], "") => 7,
    join(input_for_numbers[8], "") => 8,
    join(input_for_numbers[9], "") => 9,
    )

    digits
end

digits_data = read_input("input")
input_signals = digits_data[:,1:10]
output_digits = digits_data[:, 12:15]

input_comb = map(x->unique_combos(input_signals[x, :]), 1:size(input_signals, 1))

sum = 0
for i = 1:size(input_comb,1)
    digits = findout_numbers_inputs(input_comb[i,1])
    decoded_digits = map(x->digits[join(sort(split(x, "")), "")], output_digits[i,:])
    decoded_value = 1000*decoded_digits[1] + 100*decoded_digits[2] + 10*decoded_digits[3] +decoded_digits[4]
    println(i, ": ", decoded_value)
    global sum += decoded_value
end

println("summa: ", sum)
