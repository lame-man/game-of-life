local game = require("game")
local grid = require("grid")
local utils = require("utils")
local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600
local CELL_SIZE = 10

function love.load()
    love.window.setTitle("Game of Life")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    grid.initialize(WINDOW_WIDTH / CELL_SIZE, WINDOW_HEIGHT / CELL_SIZE)
end

function love.update(dt)
    grid.update()
end

function love.draw()
    grid.draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local col = math.floor(x / CELL_SIZE) + 1
        local row = math.floor(y / CELL_SIZE) + 1
        grid.toggleCell(row, col)
    end
end
