using HorizonSideRobots

robot = Robot("maps/task_18.sit", animate = true)

next_side(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function try_move_n_for_shuttle!(stop_condition, robot, side, n)
    for _ in 1:n
        if stop_condition() || ismarker(robot)
            break
        end
        move!(robot, side)
    end
end

function shuttle!(stop_condition, robot, side)
    n = 1
    side = next_side(side)
    while !stop_condition()
        try_move_n_for_shuttle!(stop_condition, robot, side, n)
        n += 1
        side = inverse(side)
    end
    if n % 2 == 0
        return n // 2, side
    else
        return n // 2 + 1, side
    end
end

function bypass!(robot, side)
    steps_back, side_back = shuttle!(() -> !isborder(robot, side), robot, side)
    move!(robot, side)
    for _ in 1:steps_back
        move!(robot, side_back)
    end

end

function try_move_n!(stop_condition, robot, side, n)
    for _ in 1:n
        if stop_condition()
            break
        end
        if isborder(robot, side)
            bypass!(robot, side)
        else
            move!(robot, side)
        end
    end
end

function spiral!(stop_condition, robot)
    side = West
    steps = 1
    while !stop_condition()
        for _ in 1:2
            try_move_n!(stop_condition, robot, side, steps)
            side = next_side(side)
        end
        steps += 1
    end
end

spiral!(() -> ismarker(robot), robot)