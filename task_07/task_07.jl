using HorizonSideRobots

robot = Robot("maps/task_07.sit", animate = true)

function try_move_n!(robot, side, n)
    if isborder(robot, side)
        return false
    else
        for _ in range(1, n)
            move!(robot, side)
        end
        return true
    end
end

function task7!(robot)
    steps = 1
    sides = [Ost, West]
    i = 0
    while isborder(robot, Nord)
        try_move_n!(robot, sides[i % 2 + 1], steps)
        i = i % 2 + 1
        steps += 1
    end
end

task7!(robot)