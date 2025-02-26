local panGrid = require("grid")

panGrid._original_initialize = panGrid.initialize

function panGrid.pan(dx, dy)
    panGrid.windowPosition.x = panGrid.windowPosition.x + dx
    panGrid.windowPosition.y = panGrid.windowPosition.y + dy
    if panGrid.windowPosition.x <= 0 then
        panGrid.windowPosition.x = 0
    end
    if panGrid.windowPosition.x >= panGrid.cols*panGrid.cellsize - love.graphics.getWidth() then
        panGrid.windowPosition.x = panGrid.cols*panGrid.cellsize - love.graphics.getWidth()
    end
    if panGrid.windowPosition.y <= 0 then
        panGrid.windowPosition.y = 0
    end
    if panGrid.windowPosition.y >= panGrid.rows*panGrid.cellsize - love.graphics.getHeight() then
        panGrid.windowPosition.y = panGrid.rows*panGrid.cellsize - love.graphics.getHeight()
    end 
end

function panGrid.initialize(cols, rows, cellsize)
    panGrid._original_initialize(cols, rows)
    panGrid.cellsize = cellsize
    -- initial window position right in the middle
    panGrid.windowPosition = {x = (cols*cellsize - love.graphics.getWidth()) / 2, y = (rows*cellsize - love.graphics.getHeight()) / 2}
end

function panGrid.draw()
    for x=1,panGrid.cols do
        for y=1,panGrid.rows do
            if panGrid[x][y] == 2 then
                panGrid[x][y] = 0
            elseif panGrid[x][y] == 1 then
                panGrid[x][y] = 3
            end
            if panGrid.inWindow(x, y) then
                panGrid.drawCell(x, y)
            end
        end
    end
end

function panGrid.cellToGridPixel(cell)
    return {x=(cell.col-1)*panGrid.cellsize, y=(cell.row-1)*panGrid.cellsize}
end

function panGrid.gridPixelToWindowPixel(pixel)
    return {x=pixel.x-panGrid.windowPosition.x, y=pixel.y-panGrid.windowPosition.y}
end

function panGrid.drawCell(col, row)
    love.graphics.push()
    pixel = panGrid.gridPixelToWindowPixel(panGrid.cellToGridPixel({col=col,row=row}))
    if panGrid[col][row] == 3 then
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", pixel.x, pixel.y, panGrid.cellsize, panGrid.cellsize)
    elseif panGrid[col][row] == 0 then
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("fill", pixel.x, pixel.y, panGrid.cellsize, panGrid.cellsize)
    end
    love.graphics.pop()
end

function panGrid.windowPixelToCell(pixel)
    return {col=math.floor((pixel.x+panGrid.windowPosition.x)/panGrid.cellsize) + 1, 
            row=math.floor((pixel.y+panGrid.windowPosition.y)/panGrid.cellsize) + 1}
end

function panGrid.inWindow(col, row)
    cell = {col = col, row = row}
    windowPixel = panGrid.gridPixelToWindowPixel(panGrid.cellToGridPixel(cell))
    if windowPixel.x>=0 and windowPixel.x<=love.graphics.getWidth() and windowPixel.y>=0 and windowPixel.y<=love.graphics.getHeight() then
        return true
    else
        return false
    end
end

function panGrid.toggleCell(x, y)
    cell = panGrid.windowPixelToCell({x=x, y=y})
    if panGrid[cell.col][cell.row] == 3 then
        panGrid[cell.col][cell.row] = 0
    elseif panGrid[cell.col][cell.row] == 0 then
        panGrid[cell.col][cell.row] = 3
    end
end

return panGrid
