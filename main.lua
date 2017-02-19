love.window.setMode(800, 600)
winW,winH = love.graphics.getWidth(), love.graphics.getHeight()
local OFFSET = 10 -- offsets text from margins of screen
TC = require "tileClick"

function love.load()

end

function love.update(dt)
  TC:setMode("draw")
  if love.keyboard.isDown("e") then
    TC:setMode("erase")
  end

  if love.mouse.isDown(1) then
    TC:fill(love.mouse.getX(), love.mouse.getY())
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  TC:draw()
  love.graphics.setColor(0, 255, 0)
  love.graphics.printf(string.format("Width: %d, Height: %d\nMouse at %d, %d",
                                    winW, winH, love.mouse.getX(), love.mouse.getY()),
                        OFFSET, 0, winW, "left")
  local text = [[
              hold to erase -   E
              fill window -     F
              wipe window -   E+F
              load from /assets -   L
              save to]]..love.filesystem.getSaveDirectory()..[[ -   S ]]
  love.graphics.printf(text, 0, 0, winW - OFFSET, "right")
end

function love.keypressed(key)
  if key == "s" then
    love.filesystem.write("map.lua", TC:printStr())
  elseif key == "l" then
    TC:loadMap("assets/map.lua")
  elseif key == "f" then
    TC:cover()
  end

end
