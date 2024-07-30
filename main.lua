local points = {
    {-1, -1, -1}, {1, -1, -1}, {1, -1, 1}, {-1, -1, 1},
    {-1, 1, -1}, {1,1,-1}, {1,1,1}, {-1, 1, 1}
}

local vertices = {
    {1,2}, {2,3}, {3,4}, {4,1},
    {5,6}, {6,7}, {7,8}, {8,5},
    {1,5}, {2,6}, {3,7}, {4,8}
}

local rotation = 0
local fov = 10

function RotateX(point)
    local x, y, z = point[1], point[2], point[3]
    
    return {
        x,
        math.cos(rotation) * y - math.sin(rotation) * z,
        math.sin(rotation) * y + math.cos(rotation) * z
    }
end

function RotateY(point)
    local x, y, z = point[1], point[2], point[3]
    
    return {
        math.cos(rotation) * x - math.sin(rotation) * z,
        y,
        math.sin(rotation) * x + math.cos(rotation) * z
    }
end

function Projection(point)
    local x, y, z = point[1], point[2], point[3]
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()

    return {
        w / 2 + (fov * x) / (fov + z) * 100,
        h / 2 + (fov * y) / (fov + z) * 100
    }
end

function love.load()

end

function love.update(dt)
    rotation = rotation + dt
end

function love.draw()
    for _, vertex in ipairs(vertices) do
        print(vertex[1], vertex[2])
        rotatedStart = RotateX(RotateY(points[vertex[1]]))
        rotatedEnd = RotateX(RotateY(points[vertex[2]]))
        start = Projection(rotatedStart)
        _end = Projection(rotatedEnd)

        love.graphics.line(start[1], start[2], _end[1], _end[2])
    end
end