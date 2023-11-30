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

function task2!(robot)::Nothing
    flag = false
    if isborder(robot, West)  # Проверка, прижат ли робот к левой стене изначально
        flag = true
    end
    sides = [Ost, Sud, West, Nord]
    steps = num_steps_along!(robot, Nord)
    putmarker!(robot)
    for i in 1:4
        put_markers_along!(robot, sides[i])
    end
    while true
        move!(robot, Ost)
        if ismarker(robot)
            break
        end
        putmarker!(robot)
    end
    for i in 1:steps
        move!(robot, Sud)
    end
    if flag
        move!(robot, West)
    end
end

task2!(r)