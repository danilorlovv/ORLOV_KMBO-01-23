using HorizonSideRobots

robot = Robot("maps/default.sit", animate = true)

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function recursion_along!(robot, side, steps)
    if !isborder(robot, side)
        move!(robot, side)
        steps += 1
        steps += recursion_along!(robot, side, steps)
        return steps
    else 
        putmarker!(robot)
        try_move_n!(robot, inverse(side), steps)
        return 0
    end
end

function try_move_n!(robot, side, n)
    for _ in 1:n
        if isborder(robot, side)
            break
        end
        move!(robot, side)
    end
end

recursion_along!(robot, Sud, 0)