using DelimitedFiles

function agg_movement(filename) 
    f=open(filename)
    planned_course=readdlm(f)
    forward_course = (planned_course[:,1].=="forward") .* planned_course[:,2]
    down_course = (planned_course[:,1].=="down") .* planned_course[:,2]
    up_course = (planned_course[:,1].=="up") .* planned_course[:,2]

    course = [forward_course (up_course-down_course)]

    movement=sum(course, dims=1)

    movement[1]*-movement[2]
end

println(agg_movement("test-input"))
println(agg_movement("input"))
