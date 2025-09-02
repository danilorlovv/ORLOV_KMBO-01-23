using HorizonSideRobots

robot = Robot("maps/task_11.sit", animate = true)

function try_move!(robot, side)
    if isborder(robot, side)
        return false
    else
        move!(robot, side)
        return true
    end
end

function along!(robot, side)
    while try_move!(robot, side) end
end

function along_n!(robot, side, n)
    for _ in range(1, n) 
        try_move!(robot, side)
    end
end

function numsteps_along!(robot, side)
    n = 0
    while try_move!(robot, side)
        n += 1
    end
    return n
end

function count_along!(robot, side)
    counter = 0
    while !isborder(robot, side)
        move!(robot, side)
        if isborder(robot, Sud)
            counter += 1
            while isborder(robot, Sud)
                move!(robot, side)
            end
        end
    end
    return counter
end

function task11!(robot)
    back_ost = numsteps_along!(robot, West)
    back_nord = numsteps_along!(robot, Sud)
    counter = 0
    sides = [Ost, West]
    i = 0
    move!(robot, Nord)
    while true
        counter += count_along!(robot, sides[i % 2 + 1])
        i += 1
        if isborder(robot, Nord)
            break
        end
        move!(robot, Nord)
    end
    along!(robot, West)
    along!(robot, Sud)
    along_n!(robot, Nord, back_nord)
    along_n!(robot, Ost, back_ost)
    print(counter)
end

task11!(robot)