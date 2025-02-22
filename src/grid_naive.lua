local grid = {}
local nextGrid = {}
function grid.initialize(cols, rows)
    grid.cols = cols
    grid.rows = rows
    grid.cellsize = love.graphics.getWidth() / cols
    for x=1,cols do
        grid[x] = {}
        nextGrid[x] = {}
        for y=1,rows do
            grid[x][y] = 0
            nextGrid[x][y] = 0
        end
    end
end

function grid.getNeighborValues(col, row)
    neighbors = {}
    for i=-1,1 do
        for j=-1,1 do
            if (grid.rows >= row + i) and (row + i > 0) and (grid.cols >= col + j) and (col + j > 0) and not(i == 0 and j == 0) then            
                table.insert(neighbors, grid[col + j][row + i])
            end
        end
    end
    return neighbors
end

function grid.applyRules(x, y)
    neighborValues = grid.getNeighborValues(x, y)
    count_off = 0
    count_on = 0
    for i,neighbor in ipairs(neighborValues) do
        if neighbor == 1 then
            count_on = count_on + 1
        elseif neighbor == 0 then
            count_off = count_off + 1
        end
    end
    if count_on == 3 then
        nextGrid[x][y] = 1
    elseif count_on == 2 then
        nextGrid[x][y] = grid[x][y]
    else
        nextGrid[x][y] = 0
    end
end

function grid.update()
    for x = 1, grid.cols do
        for y = 1, grid.rows do
            nextGrid[x][y] = 0
        end
    end
    for x=1,grid.cols do
        for y=1,grid.rows do
            grid.applyRules(x, y)
        end
    end
    for x=1,grid.cols do
        for y=1,grid.rows do
            grid[x][y] = nextGrid[x][y]
        end
    end
end

function grid.draw()
    for x=1,grid.cols do
        -- draw a white line from position X=x*cellsize from Y=0 to Y=window.height
        --love.graphics.line(x*grid.cellsize, 0, x*grid.cellsize, love.graphics.getHeight())
        for y=1,grid.rows do
            -- draw a white line from position Y=y*cellsize from X=0 to X=window.width
            --love.graphics.line(0, y*grid.cellsize, love.graphics.getWidth(), y*grid.cellsize)
            love.graphics.push()
            if grid[x][y] == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", (x-1)*grid.cellsize, (y-1)*grid.cellsize, grid.cellsize, grid.cellsize)
            elseif grid[x][y] == 0 then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", (x-1)*grid.cellsize, (y-1)*grid.cellsize, grid.cellsize, grid.cellsize)
            end
            love.graphics.pop()
        end
    end
end

function grid.toggleCell(col, row)
    if grid[col][row] == 1 then
        grid[col][row] = 0
    else
        grid[col][row] = 1
    end
end


return grid
