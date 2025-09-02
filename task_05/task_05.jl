using HorizonSideRobots

r = Robot("maps/task_05.sit", animate = true)

function along!(robot, direct)::Nothing
    while !isborder(robot, direct)
        move!(robot, direct)
    end
end

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

function task5!(robot)::Nothing
    sides = [Ost, Sud, West, Nord]
    stepsNord = num_steps_along!(robot, Nord)
    stepsWest = num_steps_along!(robot, West)
    putmarker!(robot)
    for i in sides
        put_markers_along!(robot, i)
    end
    sides = [Ost, West]
    i = 1
    while true
        move!(robot, sides[i])
        if isborder(robot, sides[i])
            if !ismarker(robot)
                move!(robot, Nord)
                putmarker!(robot)
                sides = [West, Sud, Ost, Nord]
                for i in 1:4
                    move!(robot, sides[i])
                    while isborder(robot, sides[i % 4 + 1])
                        putmarker!(robot)
                        move!(robot, sides[i])
                    end
                    putmarker!(robot)
                end
                break
            end
            move!(robot, Sud)
            i = i % 2 + 1
        end
    end          
    along!(robot, Nord)
    along!(robot, West)
    for i in 1:stepsNord
        move!(robot, Sud)
    end
    for i in 1:stepsWest
        move!(robot, Ost)
    end
end

task5!(r)