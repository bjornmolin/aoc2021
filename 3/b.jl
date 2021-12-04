using Statistics

function oxygen_report(column, data) 
    m = mean(data[:,column])
    most_common = round(m, RoundNearestTiesUp)

    indexes_to_keep = findall(data[:,column].==most_common)

    next_data = data[indexes_to_keep, :]

    (nrows, ncols) = size(next_data)

    if column < ncols  && nrows > 1  
        next_data = oxygen_report(column + 1, next_data)
    end
    next_data
end

function coscrubber_report(column, data) 
    m = mean(data[:,column])
    least_common = 1 - round(m, RoundNearestTiesUp)

    indexes_to_keep = findall(data[:,column].==least_common)

    next_data = data[indexes_to_keep, :]

    (nrows, ncols) = size(next_data)
    if column < ncols && nrows > 1  
        next_data = coscrubber_report(column + 1, next_data)
    end
    next_data
end


function gamma(filename) 
    DATA = Matrix{Int}(undef, 0, 12)
    f=open(filename ) do file
        while !eof(file)
            input = readline(file)
            rowdata = split(input, "");
            row = parse.(Int, rowdata)
            DATA = [DATA;row']
        end    
        close(file)

        m = mean(DATA, dims=1)
        gamma = m.>0.5

        gammaJoined = join(Int.(gamma), "");
        decimalGamma = parse(Int, gammaJoined, base=2)


        epsilon = m.<0.5
        epsilonJoined = join(Int.(epsilon), "");
        decimalepsilon = parse(Int, epsilonJoined, base=2)

        
        println("RESULT gamma: ", decimalGamma, " epsilon: ", decimalepsilon, " result: ", decimalGamma*decimalepsilon)

        oxygen = oxygen_report(1, DATA)
        oxygenJoined = join(Int.(oxygen), "");
        decimaloxygen = parse(Int, oxygenJoined, base=2)
        println("OXYGEN: ", decimaloxygen)

        coscrubber = coscrubber_report(1, DATA)
        println("A", coscrubber)
        coscrubberJoined = join(Int.(coscrubber), "");
        println("B", coscrubberJoined)
        decimalcoscrubber = parse(Int, coscrubberJoined, base=2)
        println("coscrubber: ", decimalcoscrubber)

        println(decimalcoscrubber*decimaloxygen)
    end
   
    
end

gamma("input")