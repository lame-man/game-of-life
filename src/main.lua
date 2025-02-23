-- local grid = require("grid_naive")
local grid = require("pan_grid")
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600
local CELL_SIZE = 10
local gamestate = "menu"
local count = 0

function love.load()
    love.window.setTitle("Game of Life")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    -- grid.initialize(WINDOW_WIDTH / CELL_SIZE, WINDOW_WIDTH / CELL_SIZE)
    grid.initialize(WINDOW_WIDTH, WINDOW_WIDTH, CELL_SIZE)
end

function love.update(dt)
    if gamestate == "play" then
        grid.update()
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    grid.draw()
    love.graphics.push()
    love.graphics.setColor(0, 1, 1)
    love.graphics.print("Current Game State: " .. gamestate, 20, 20,0, 2, 2)
    love.graphics.pop()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gamestate == "menu" then
        grid.toggleCell(x, y)
    end
end

function love.keypressed(key)
    if key == "return" then  
        if gamestate == "menu" then
            gamestate = "play"
        elseif gamestate == "play" then
            gamestate = "menu" 
        end
    end
end
