using HorizonSideRobots

robot = Robot("maps/task_07.sit", animate = true)

inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side) + 2, 4))

function shuttle!(stop_condition, robot)
    n = 1
    side = Ost
    while !stop_condition()
        try_move_n!(stop_condition, robot, side, n)
        n += 1
        side = inverse(side)
    end
end


function try_move_n!(stop_condition, robot, side, n)
    if stop_condition()
        return false     
    else
        for _ in range(1, n)
            move!(robot, side)
        end
        return true   
    end
end

shuttle!(() -> !isborder(robot, Nord), robot)