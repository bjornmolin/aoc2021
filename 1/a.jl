using DelimitedFiles

function sum_increase(filename) 
    f=open(filename)
    measurements=readdlm(f, Int32)

    shifted_measurements = circshift(measurements, (1))
    sum(measurements.>shifted_measurements)
end

println(sum_increase("test-input"))
println(sum_increase("input"))
