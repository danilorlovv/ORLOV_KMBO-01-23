using HorizonSideRobots

robot = Robot("maps/task_08.sit", animate = true)

next_side(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))

function try_move_n!(stop_condition, robot, side, n)
    for _ in range(1, n)
        if stop_condition()
            break
        end
        move!(robot, side)
    end
end

function spiral!(stop_condition, robot)
    side = Ost
    steps = 1
    while !stop_condition()
        for i in 1:2
            try_move_n!(stop_condition, robot, side, steps)
            side = next_side(side)
        end
        steps += 1
    end
end

spiral!(() -> ismarker(robot), robot)