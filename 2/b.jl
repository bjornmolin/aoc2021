using DelimitedFiles

function agg_movement(filename) 
    f=open(filename)
    planned_course=readdlm(f)
    forward_course = (planned_course[:,1].=="forward") .* planned_course[:,2]
    down_course = (planned_course[:,1].=="down") .* planned_course[:,2]
    up_course = (planned_course[:,1].=="up") .* planned_course[:,2]

    aim = down_course - up_course;
    aggregated_aim = zero(aim)
    for i in 1:length(aim)
        aggregated_aim[i] = sum(aim[1:i])
    end
    
    movement = [forward_course aggregated_aim.*forward_course]
    sum_movement = sum(movement, dims=1)
    sum_movement[1]*sum_movement[2]
end

println(agg_movement("test-input"))
println(agg_movement("input"))
