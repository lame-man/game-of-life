-- local grid = require("grid_naive")
local grid = require("pan_grid")
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600
local CELL_SIZE = 10
local gamestate = "menu"
local count = 0
local keys = {
    up = false,
    down = false,
    right = false,
    left = false
}
local gridSpeed = 10
function love.load()
    love.window.setTitle("Game of Life")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    -- grid.initialize(WINDOW_WIDTH / CELL_SIZE, WINDOW_WIDTH / CELL_SIZE)
    grid.initialize(WINDOW_WIDTH/5, WINDOW_WIDTH/5, CELL_SIZE)
end

function love.update(dt)
    if keys.right then
        grid.pan(gridSpeed, 0)
    elseif keys.left then
        grid.pan(-gridSpeed, 0)
    elseif keys.up then
        grid.pan(0, -gridSpeed)
    elseif keys.down then
        grid.pan(0, gridSpeed)
    end
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
    elseif key == "up" then
        keys.up = true
    elseif key == "down" then
        keys.down = true
    elseif key == "right" then
        keys.right = true
    elseif key == "left" then
        keys.left = true
    end
end


function love.keyreleased(key)
    if key == "up" then
        keys.up = false
    elseif key == "down" then
        keys.down = false
    elseif key == "right" then
        keys.right = false
    elseif key == "left" then
        keys.left = false
    end
end