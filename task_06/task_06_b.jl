using HorizonSideRobots

r = Robot("maps/task_06.sit", animate = true)

inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side) + 2, 4))
nextside(Side::HorizonSide) = HorizonSide(mod(Int(Side) + 1, 4))
prevside(Side::HorizonSide) = HorizonSide(mod(Int(Side) - 1, 4))

function corner_side(side_1::HorizonSide, side_2::HorizonSide)
    moves = []
    true_distance_1 = 0
    true_distance_2 = 0
    while !isborder(r, side_2) || !isborder(r, side_1)
        if isborder(r, side_2)
            move!(r, side_1)
            push!(moves, side_1)
            true_distance_1 += 1
        else
            move!(r, side_2)
            push!(moves, side_2)
            true_distance_2 += 1
        end
    end
    return [[true_distance_1, side_1], [true_distance_2, side_2], reverse(moves)]
end

function deviation_fix(instruction)
    for i in 1:instruction[1]
        move!(r, inverse(instruction[2]))
    end
    putmarker!(r)
    for i in 1:instruction[1]
        move!(r, instruction[2])
    end
end

function go_inverse(move)
    for i in move
        move!(r, inverse(i))
    end
end

function task6b!()
    for i in [[Ost, Nord], [West, Sud]]
        base = corner_side(i[1], i[2])
        deviation_fix(base[1])
        deviation_fix(base[2])
        go_inverse(base[3])
    end
end

task6b!()