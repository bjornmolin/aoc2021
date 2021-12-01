using DelimitedFiles
using Pkg
Pkg.add("RollingFunctions") 
using RollingFunctions

function sum_windows(filename) 
    f=open(filename)
    measurements=readdlm(f, Int64)
    rollsum = rolling(sum, measurements[:,1], 3)
    shifted_rollsum = circshift(rollsum, (1))
    sum(rollsum.>shifted_rollsum)
end

println(sum_windows("test-input"))
println(sum_windows("input"))