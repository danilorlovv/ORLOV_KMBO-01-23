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

function task4!(robot)::Nothing
    putmarker!(r)
    num_steps1 = 0
    num_steps2 = 0
    sidesup = [Nord, West, Sud, Ost, Nord]
    sidesback = [Sud, Ost, Nord, West, Sud]
    for i in 1:4
        while true
            if !isborder(robot, sidesup[i])
                move!(robot, sidesup[i])
                num_steps1 += 1
            else
                break
            end
            if !isborder(robot, sidesup[i + 1])
                move!(robot, sidesup[i + 1])
                num_steps2 += 1
            else
                break
            end
            putmarker!(robot)
        end
        while num_steps1 != 0
            move!(robot, sidesback[i])
            num_steps1 -= 1
        end
        while num_steps2 != 0
            move!(robot, sidesback[i + 1])
            num_steps2 -= 1
        end
    end
end

task4!(r)