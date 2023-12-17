using HorizonSideRobots

robot = Robot("maps/task_21.sit", animate = true) 

next_side(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function try_move_n!(robot, side, n)
    for _ in 1:n
        if isborder(robot, side)
            break
        end
        move!(robot, side)
    end
end

function through_the_wall!(robot, side, steps = 0)
    left_side = next_side(side)
    if !isborder(robot, side)
        move!(robot, side)
        try_move_n!(robot, inverse(left_side), steps)
    else
        if isborder(robot, side)
            move!(robot, left_side)
            steps += 1
            x = through_the_wall!(robot, side, steps)
            steps += x
            return steps
        end
    end
    return 0
end

through_the_wall!(robot, Sud)