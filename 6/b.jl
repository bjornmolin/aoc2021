using DelimitedFiles

function read_input(filename) 
    fishes_file=readdlm(filename, ',', Int)
    days = 0:8
    map(day -> sum(fishes_file.==day), days) 
end

function simulate_day(fishes)
    fishes = circshift(fishes, (-1))
    fishes[7]+= fishes[9]
    fishes
end

function run_simulation(input_file_name, number_of_days)
    fishes = read_input(input_file_name)

    #println("Initial state ", fishes)

    for i in 1:number_of_days
        fishes = simulate_day(fishes)
     #   println("After ", i, " days: ", fishes)
    end 
    println("Number of fishes after ", number_of_days, ": ", sum(fishes))
end

run_simulation("test-input", 18)
run_simulation("test-input", 80)
run_simulation("test-input", 256)

run_simulation("input", 256)
