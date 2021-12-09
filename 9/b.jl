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


function basin_from_point(bordered_data, detected_basin, i, j) 
    new_detected_basin = detected_basin
    new_detected_basin[i, j] = 1
    if (bordered_data[i,j]) < bordered_data[i-1, j] && bordered_data[i-1, j]<9
        new_detected_basin = basin_from_point(bordered_data, detected_basin, i-1, j)
    end
    if (bordered_data[i,j]) < bordered_data[i+1, j] && bordered_data[i+1, j]<9
        new_detected_basin = basin_from_point(bordered_data, detected_basin, i+1, j)
    end
    if (bordered_data[i,j]) < bordered_data[i, j-1] && bordered_data[i, j-1]<9
        new_detected_basin = basin_from_point(bordered_data, detected_basin, i, j-1)
    end
    if (bordered_data[i,j]) < bordered_data[i, j+1] && bordered_data[i, j+1]<9
        new_detected_basin = basin_from_point(bordered_data, detected_basin, i, j+1)
    end

    new_detected_basin
end


data = read_input("input")

border_h = ones(1, size(data, 2)).*10

bordered_data = [border_h;data;border_h]
low_points = Matrix{Int}(undef, 0, 2)

sum_min = 0
datasize = size(bordered_data)
for i in 2:datasize[1]-1
    for j in 2:datasize[2]-1
        if (bordered_data[i,j]) < bordered_data[i-1, j] &&
            (bordered_data[i,j]) < bordered_data[i+1, j] &&
            (bordered_data[i,j]) < bordered_data[i, j-1] &&
            (bordered_data[i,j]) < bordered_data[i, j+1] 
            
            global low_points = [low_points;[i j]]
            global sum_min += bordered_data[i,j]+1
        end
    end
end

basin_sizes = Array{Int}(undef, 0, 1)
for pointIndex in 1:size(low_points, 1)
    basin = basin_from_point(bordered_data, zeros(size(bordered_data)), low_points[pointIndex,1], low_points[pointIndex,2])
    basin_size = sum(basin)
    global basin_sizes = [basin_sizes;basin_size]
end

sorted_basins_sizes = sort(basin_sizes, dims=1, rev=true)

println(sorted_basins_sizes[1])
println(sorted_basins_sizes[2])
println(sorted_basins_sizes[3])

println("Product of three largest basins: ", Int(sorted_basins_sizes[1]*sorted_basins_sizes[2]*sorted_basins_sizes[3]))