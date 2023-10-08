using HorizonSideRobots

r = Robot("maps/task_7.sit", animate = true)

function task7!(robot)
    while isborder(robot, Nord)
        move!(robot, Ost)
    end
end

task7!(r)