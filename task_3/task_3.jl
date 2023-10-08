using HorizonSideRobots

r = Robot("maps/default.sit", animate = true)

function num_steps_along!(robot, direct)::Int
    num_steps = 0
    while !isborder(robot, direct)
        move!(robot, direct)
        num_steps += 1
    end
    return num_steps
end

function put_markers_along!(robot, direct)::Nothing
    while !isborder(robot, direct)
        move!(robot, direct)
        putmarker!(robot)
    end
end

function task3!(robot)::Nothing
    sides = [Ost, West]
    stepsNord = num_steps_along!(robot, Nord)
    stepsWest = num_steps_along!(robot, West)
    putmarker!(robot)
    i = 1
    while true
        put_markers_along!(robot, sides[i])
        i+=1
        if !isborder(robot, Sud)
            move!(robot, Sud)
            putmarker!(robot)
        else
            break
        end
        put_markers_along!(robot, sides[i])
        i-=1
        if !isborder(robot, Sud)
            move!(robot, Sud)
            putmarker!(robot)
        else
            break
        end
    end
    put_markers_along!(robot, West)
    put_markers_along!(robot, Nord)
    for i in 1:stepsNord
        move!(robot, Sud)
    end
    for i in 1:stepsWest
        move!(robot, Ost)
    end
end

task3!(r)