using DelimitedFiles
using Statistics

function read_input(filename) 
    crabs=readdlm(filename, ',', Int)
    crabs
end


crabs  = read_input("test-input")

fuel_to_position = Array{Int}(undef, 1,0)
positions = 0:maximum(crabs)

for position in positions


    global fuel_to_position = [fuel_to_position sum(abs.(crabs.-position ))]

end

println(minimum(fuel_to_position))