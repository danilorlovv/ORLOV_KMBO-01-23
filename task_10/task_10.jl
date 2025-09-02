using HorizonSideRobots
robot = Robot("maps/default.sit", animate = true)

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

function chess_n!(robot, side, n)
    while !isborder(robot, side)
        for _ in range(1, n)
            putmarker!(robot)
            if !try_move!(robot, side)
                break
            end
        end
        for _ in range(1, n)
            if !try_move!(robot, side)
                break
            end
        end
    end
    if isborder(robot, Nord)
        return false
    else
        return true
    end
end

function task10!(robot, n)
    back_ost = numsteps_along!(robot, West)
    back_nord = numsteps_along!(robot, Sud)
    counter = 0
    while chess_n!(robot, Ost, n)
        try_move!(robot, Nord)
        along!(robot, West)
        counter += 1
        if counter % (2 * n) >= n
            along_n!(robot, Ost, n)
        end
    end
    along!(robot, West)
    along!(robot, Sud)
    along_n!(robot, Ost, back_ost)
    along_n!(robot, Nord, back_nord)
end

task10!(robot, 3)