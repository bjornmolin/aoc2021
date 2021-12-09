using DelimitedFiles

function read_input(filename) 
    digits_data=readdlm(filename, ' ', String)
    digits_data
end


digits_data = read_input("input");
display(digits_data)

println("2")
ones = (length.(digits_data).==2)
display(ones)
println("")

println("3")
sevens = (length.(digits_data).==3)
display(ones)
println("")

println("4")
fours = (length.(digits_data).==4)
display(ones)
println("")


println("7")
eights = (length.(digits_data).==7)
display(ones)
println("")

count_ones = sum(ones[:,12:15])
count_sevens = sum(sevens[:,12:15])
count_fours = sum(fours[:,12:15])
count_eights = sum(eights[:,12:15])

println(count_ones + count_sevens + count_fours + count_eights)