using HorizonSideRobots

robot = Robot("maps/task_14.sit", animate = true)

inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side) + 2, 4))

function try_move!(robot, side, k)
    if isborder(robot, side)
        return k
    else
        move!(robot, side)
        return k % 2 + 1
    end
end

function along!(robot, direct)::Nothing
    while !isborder(robot, direct)
        move!(robot, direct)
    end
end

function bottom_left!(robot)
    moves = []
    while !isborder(robot, Sud) || !isborder(robot, West)
        if isborder(robot, Sud)
            move!(robot, West)
            push!(moves, West)
        else
            move!(robot, Sud)
            push!(moves, Sud)
        end
    end
    return reverse(moves)
end

function go_back!(robot, moves)
    along!(robot, West)
    along!(robot, Sud)
    for i in moves
        move!(robot, inverse(i))
    end
end

function border!(robot, k)
    sides = [Nord, West, Sud]
    width = 1
    while !isborder(robot, Ost)
        if k % 2 == 0
            putmarker!(robot)
        end
        k = try_move!(robot, Ost, k)
        width += 1
    end
    if k % 2 == 0
        putmarker!(robot)
    end
    for i in sides
        k = chess_for_border!(robot, i, k)
    end
    return width, k
end

function bypass!(robot, side, k)
    border_length = 0
    border_width = 0
    while isborder(robot, side)
        if k % 2 == 0
            putmarker!(robot)
        end
        k = try_move!(robot, Nord, k)
        border_length += 1
    end
    if k % 2 == 0
        putmarker!(robot)
    end
    k = try_move!(robot, side, k)
    border_width += 1
    while isborder(robot, Sud)
        if k % 2 == 0
            putmarker!(robot)
        end
        k = try_move!(robot, side, k)
        border_width += 1
    end
    for _ in range(1, border_length)
        if k % 2 == 0
            putmarker!(robot)
        end
        k = try_move!(robot, Sud, k)
    end
    return k, border_width
end

function chess_for_border!(robot, side, k)
    while !isborder(robot, side)
        if k % 2 == 0
            putmarker!(robot)
        end
        k = try_move!(robot, side, k)
    end
    if k % 2 == 0
        putmarker!(robot)
    end
    return k
end

function chess!(robot, side, k, width)
    way = 1
    while way < width - 2
        while isborder(robot, side)
            k, border_width = bypass!(robot, side, k)
            way += border_width
        end
        if way >= width - 2
            break
        end
        if k % 2 == 0
            putmarker!(robot)
        end
        k = try_move!(robot, side, k)
        way += 1
    end
    if k % 2 == 0
        putmarker!(robot)
    end
    return k
end

function snake!(robot, start_side, ortogonal_side, k, width)
    side = start_side
    while true
        k = chess!(robot, side, k, width)
        if isborder(robot, side)
            k, border_width = bypass!(robot, side, k)
        else
            k = try_move!(robot, side, k)
        end
        if isborder(robot, ortogonal_side)
            break
        end
        k = try_move!(robot, ortogonal_side, k)
        side = inverse(side)
        k = try_move!(robot, side, k)
    end
end

function task14!(robot)
    moves = bottom_left!(robot)
    if (length(moves)) % 2 == 0
        width, k = border!(robot, 0)
    else
        width, k = border!(robot, 1)
    end
    k = try_move!(robot, Ost, k)
    snake!(robot, Ost, Nord, k, width)
    go_back!(robot, moves)
end

task14!(robot)