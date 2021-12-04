using Statistics

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

        
        println(DATA)

        m = mean(DATA, dims=1)
        println("LIKA", sum(m.==0.5))
        gamma = m.>0.5

        gammaJoined = join(Int.(gamma), "");
        decimalGamma = parse(Int, gammaJoined, base=2)


        epsilon = m.<0.5
        epsilonJoined = join(Int.(epsilon), "");
        decimalepsilon = parse(Int, epsilonJoined, base=2)

        println("RESULT gamma: ", decimalGamma, " epsilon: ", decimalepsilon, " result: ", decimalGamma*decimalepsilon)
    end
   
    
end

gamma("input")