local grid_naive = require("grid_naive")
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600
local CELL_SIZE = 10
local gamestate = "menu"
local count = 0

function love.load()
    love.window.setTitle("Game of Life")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    grid_naive.initialize(WINDOW_WIDTH / CELL_SIZE, WINDOW_HEIGHT / CELL_SIZE)
end

function love.update(dt)
    if gamestate == "play" then
        grid_naive.update()
    end
end

function love.draw()
    grid_naive.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Current Game State: " .. gamestate, 10, 10)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gamestate == "menu" then
        local col = math.floor(x / CELL_SIZE) + 1
        local row = math.floor(y / CELL_SIZE) + 1
        grid_naive.toggleCell(col, row)
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
