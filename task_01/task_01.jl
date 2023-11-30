using HorizonSideRobots

r = Robot("maps/default.sit", animate = true)

function task1!(robot)::Nothing
    putmarker!(r)
    num_steps = 0
    sidesup = [Nord, West, Sud, Ost]
    sidesback = [Sud, Ost, Nord, West]
    for i in 1:4
        while !isborder(robot, sidesup[i])
            move!(robot, sidesup[i])
            putmarker!(robot)
            num_steps += 1
        end
        while num_steps != 0
            move!(robot, sidesback[i])
            num_steps -= 1
        end
    end
end

task1!(r)