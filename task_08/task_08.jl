using HorizonSideRobots

r = Robot("maps/task_08.sit", animate = true)

function task8!(robot)
    sides = [Nord, West, Sud, Ost, Nord]
    i = 1
    steps = 1
    while !ismarker(robot)
        for j in 1:steps
            move!(robot, sides[i])
            if ismarker(robot) break end
        end
        if ismarker(robot) break end
        for j in 1:steps
            move!(robot, sides[i + 1])
            if ismarker(robot) break end
        end
        steps += 1
        i += 2
        if i == 5
            i = 1
        end
    end
end

task8!(r)