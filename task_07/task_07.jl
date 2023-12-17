using HorizonSideRobots

r = Robot("maps/task_07.sit", animate = true)

function task7!(robot)
    while isborder(robot, Nord)
        move!(robot, Ost)
    end
end

task7!(r)