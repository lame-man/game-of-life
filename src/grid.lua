local grid = {}
-- John Conway's game of life with 0,1,2,3 corresponding to dead, alive-next, dead-next, alive.
-- If there are exactly three neighbors alive, the cell gets to live. Otherwise it dies.
function grid.initialize(cols, rows)
    grid.cols = cols
    grid.rows = rows
    grid.cellsize = love.graphics.getWidth() / cols
    for x=1,cols do
        grid[x] = {}
        for y=1,rows do
            grid[x][y] = 0
        end
    end
end

function grid.getNeighborValues(x, y)
    neighborValues = {}
    for i=-1,1 do
        for j=-1,1 do
            if not(i==0 and j==0) and i+x<=grid.cols and i+x>0 and j+y<=grid.rows and j+y>0 then
                table.insert(neighborValues, grid[i+x][j+y])
            end
        end
    end
    return neighborValues
end

function grid.applyRules(x, y)
    -- val = 2 means going to die, val = 1 means going to live
    neighborValues = grid.getNeighborValues(x, y)
    count_on = 0
    for i, val in ipairs(neighborValues) do
        if val == 3 or val == 2 then
            count_on = count_on + 1
        end
    end
    if count_on == 3 then
        if grid[x][y] == 0 then
            grid[x][y] = 1
        end
    elseif count_on == 2 then
    else
        if grid[x][y] == 3 then
            grid[x][y] = 2
        end
    end
end
function grid.update()
    for x=1,grid.cols do
        for y=1,grid.rows do
            grid.applyRules(x,y)
        end
    end
end

function grid.draw()
    for x=1,grid.cols do
        for y=1,grid.rows do
            love.graphics.push()
            if grid[x][y] == 0 or grid[x][y] == 2 then
                grid[x][y] = 0
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", (x-1)*grid.cellsize, (y-1)*grid.cellsize, grid.cellsize, grid.cellsize)
            elseif grid[x][y] == 3 or grid[x][y] == 1 then
                grid[x][y] = 3
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", (x-1)*grid.cellsize, (y-1)*grid.cellsize, grid.cellsize, grid.cellsize)
            end
            love.graphics.pop()
        end
    end
end

function grid.toggleCell(x, y)
    CELL_SIZE = grid.cellsize
    col = math.floor(x / CELL_SIZE) + 1
    row = math.floor(y / CELL_SIZE) + 1
    if grid[col][row] == 3 then
        grid[col][row] = 0
    elseif grid[col][row] == 0 then
        grid[col][row] = 3
    end
end

return grid