local panGrid = require("grid")

panGrid._original_initialize = panGrid.initialize

function panGrid.pan(dx, dy)
    
end

function panGrid.initialize(cols, rows, cellsize)
    panGrid._original_initialize(cols, rows)
    panGrid.cellsize = cellsize
    panGrid.windowPosition = {col = (cols - love.graphics.getWidth() / cellsize) / 2, row = (rows - love.graphics.getHeight() / cellsize) / 2}
    panGrid.windowScale = cellsize -- 10 pixels/cell for example
end

function panGrid.draw()
    for x=1,panGrid.cols do
        for y=1,panGrid.rows do
            if panGrid[x][y] == 2 then
                panGrid[x][y] = 0
            elseif panGrid[x][y] == 1 then
                panGrid[x][y] = 3
            end
        end
    end
    for col=0,love.graphics.getWidth()/panGrid.cellsize do
        col = col + panGrid.windowPosition.col
        for row=0,love.graphics.getHeight()/panGrid.cellsize do
            row = row + panGrid.windowPosition.row
            love.graphics.push()
            if panGrid[col][row] == 0 then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", (col)*panGrid.cellsize, (row)*panGrid.cellsize, panGrid.cellsize, panGrid.cellsize)
            elseif panGrid[col][row] == 3 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", (col)*panGrid.cellsize, (row)*panGrid.cellsize, panGrid.cellsize, panGrid.cellsize)
            end
            love.graphics.pop()
        end
    end
end

function panGrid.pixelToCell(x, y)
    position = {
        col=math.floor(panGrid.windowPosition.col + x/panGrid.cellsize),
        row=math.floor(panGrid.windowPosition.row + y/panGrid.cellsize)
    }
    return position
end

function panGrid.cellToPixel(col, row)
    position = {
        x=math.floor(panGrid.windowPosition.col + x/panGrid.cellsize),
        y=math.floor(panGrid.windowPosition.row + y/panGrid.cellsize)
    }
end

function panGrid.toggleCell(x, y)
    print("Clicked on pixel",x,y)
    cell = panGrid.pixelToCell(x, y)
    print("Clicked on cell:", cell.col,cell.row)
    if panGrid[cell.col][cell.row] == 3 then
        panGrid[cell.col][cell.row] = 0
    elseif panGrid[cell.col][cell.row] == 0 then
        panGrid[cell.col][cell.row] = 3
    end
end
return panGrid
