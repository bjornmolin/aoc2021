using DelimitedFiles

function read_input(filename) 
    fishes=readdlm(filename, ',', Int)
    fishes
end

function simulate_day(fishes)
    breed = fishes.==0;

    number_of_new = sum(breed)

    fishes = (fishes + breed.*7).-1

    [fishes ones(1,number_of_new).*8]
end

function run_simulation(input_file_name, number_of_days)
    fishes = read_input(input_file_name)

    #println("Initial state ", fishes)

    for i in 1:number_of_days
        fishes = simulate_day(fishes)
        #println("After ", i, " days: ", fishes)
    end 
    println("Number of fishes after ", number_of_days, ": ", size(fishes,2))
end

run_simulation("test-input", 18)
run_simulation("test-input", 80)
run_simulation("input", 80)
