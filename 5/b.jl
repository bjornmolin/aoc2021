function read_input(filename) 
    DATA = Matrix{Int}(undef, 0, 4)
    f=open(filename ) do file
        while !eof(file)
            input = readline(file)
            rowdata = split(input, " -> ")
            position1 = parse.(Int, split(rowdata[1], ","))
            position2 = parse.(Int, split(rowdata[2], ","))
            DATA = [DATA;[position1' position2' ...]]
        end    
        close(file)
    end
    DATA
end

function add_line(diagram, start_point, end_point) 
    result = diagram
    if start_point[1] == end_point[1]
        result[(start_point[2]+1):(end_point[2]+1), (start_point[1]+1)].+= 1
        result[(end_point[2]+1):(start_point[2]+1), (start_point[1]+1)].+= 1
    end
    if start_point[2] == end_point[2]

        result[(start_point[2]+1), (start_point[1]+1):(end_point[1]+1)].+= 1
        result[(start_point[2]+1), (end_point[1]+1):(start_point[1]+1)].+= 1
    end
    if (abs(start_point[1]-end_point[1])==abs(start_point[2]-end_point[2]))

        xrange = start_point[1]+1:end_point[1]+1
        if start_point[1]>end_point[1]
            xrange = start_point[1]+1:-1:end_point[1]+1
        end
        if start_point[1]==end_point[1]
            xrange = [start_point[1]]
        end
        yrange = start_point[2]+1:end_point[2]+1
        if start_point[2]>end_point[2]
            yrange = start_point[2]+1:-1:end_point[2]+1
        end
        if start_point[2]==end_point[2]
            yrange = [start_point[2]]
        end

        for i=1:size(xrange,1)
            result[yrange[i], xrange[i]]+=1
        end
    end
    result
end


data = read_input("test-input")

diagram = zeros(Int, 1000,1000);

for i = 1:size(data,1)
    global diagram = add_line(diagram, data[i,1:2], data[i, 3:4])
end

println(sum(diagram.>1))
