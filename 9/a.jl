using DelimitedFiles

function read_input(filename) 
    DATA = Matrix{Int}(undef, 0, 102)
    f=open(filename ) do file
        while !eof(file)
            input = readline(file)
            rowdata = split(input, "");
            row = parse.(Int, rowdata)
            DATA = [DATA;10 row' 10]
        end    
        close(file)
    end
    DATA
end

data = read_input("input")

border_h = ones(1, size(data, 2)).*10

bordered_data = [border_h;data;border_h]

sum_min = 0
datasize = size(bordered_data)
for i in 2:datasize[1]-1
    for j in 2:datasize[2]-1
        if (bordered_data[i,j]) < bordered_data[i-1, j] &&
            (bordered_data[i,j]) < bordered_data[i+1, j] &&
            (bordered_data[i,j]) < bordered_data[i, j-1] &&
            (bordered_data[i,j]) < bordered_data[i, j+1] 
            
            global sum_min += bordered_data[i,j]+1
        end
    end
end

println("SUM: ",    sum_min)