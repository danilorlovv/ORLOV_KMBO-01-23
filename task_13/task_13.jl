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

function along!(robot, direct)::Nothing
    while !isborder(robot, direct)
        move!(robot, direct)
    end
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

function chess!(robot, side::HorizonSide, k)::Int
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

function snake!(robot, start_side, ortogonal_side, k)
    side = start_side
    while true
        k = chess!(robot, side, k)
        if isborder(robot, ortogonal_side)
            break
        end
        move!(robot, ortogonal_side)
        k = k % 2 + 1
        side = inverse(side)
    end
end

function task13!(robot)::Nothing
    back_ost = numsteps_along!(robot, West)
    back_nord = numsteps_along!(robot, Sud)
    if (back_ost + back_nord) % 2 == 0
        snake!(robot, Ost, Nord, 0)
    else
        snake!(robot, Ost, Nord, 1)
    end
    along!(robot, West)
    along!(robot, Sud)
    along_n!(robot, Nord, back_nord)
    along_n!(robot, Ost, back_ost)
end

task13!(robot)