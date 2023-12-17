using HorizonSideRobots

robot = Robot("maps/default.sit", animate = true)

function along!(stop_condition, robot, side)
    while !stop_condition()
        move!(robot, side)
        along!(stop_condition, robot, side)
    end
end

along!(() -> isborder(robot, Ost), robot, Ost)