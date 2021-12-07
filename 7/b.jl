using DelimitedFiles
using Statistics

function read_input(filename) 
    crabs=readdlm(filename, ',', Int)
    crabs
end


crabs  = read_input("input")

fuel_to_position = Array{Integer}(undef, 1,0)
positions = 0:maximum(crabs)

for position in positions


    distances = abs.(crabs.-position )
    global fuel_to_position = [fuel_to_position sum(distances.*(distances.+1))]

end


println(minimum(fuel_to_position))
println(minimum(fuel_to_position)//2)