using HorizonSideRobots

r = Robot("maps/task_06.sit", animate = true)

inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side) + 2, 4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side) + 1, 4))
prevside(Side::HorizonSide) = HorizonSide(mod(Int(Side) - 1, 4))

function bottom_right()
    moves = []
    while !isborder(r, Sud) || !isborder(r, Ost)
        if isborder(r, Sud)
            move!(r, Ost)
            push!(moves, Ost)
        else
            move!(r, Sud)
            push!(moves, Sud)
        end
    end
    return reverse(moves)
end

function marking_outside_border(side)
    for i in 1:4
        while !isborder(r,side)
            move!(r, side)
            putmarker!(r)
        end
        side = nextside(side)
    end
end

function go_inverse(moves)
    for i in moves
        move!(r, inverse(i))
    end
end

function task6a!()
    moves = bottom_right()
    marking_outside_border(Nord)
    go_inverse(moves)
end

task6a!()