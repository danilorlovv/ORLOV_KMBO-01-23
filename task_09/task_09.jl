using HorizonSideRobots

r = Robot("maps/default.sit", animate = true)

function along!(robot, direct)::Nothing
    while !isborder(robot, direct)
        move!(robot, direct)
    end
end

function chess(robot, side::HorizonSide, k)::Int
    while !isborder(robot, side)
        if k % 2 == 0
            putmarker!(robot)
        end
        move!(robot, side)
        k = k % 2 + 1
    end
    if k % 2 == 0
        putmarker!(robot)
    end
    return k
end

function task9!(robot)::Nothing
    k = 2
    stepsWest = 0
    stepsNord = 0
    while !isborder(robot, West)
        move!(robot, West)
        stepsWest += 1
        k = k % 2 + 1
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
        stepsNord += 1
        k = k % 2 + 1
    end
    sides = [Ost, West]
    i = 1
    while true
        k = chess(robot, sides[i], k)
        if !isborder(robot, Sud)
            move!(robot, Sud)
        else
            break
        end
        k = k % 2 + 1
        i = i % 2 + 1
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

task9!(r)