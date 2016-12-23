love.window.setMode(800, 600)
winW,winH = love.graphics.getWidth(), love.graphics.getHeight()
TC = require "tileClick"

function love.load()
  --TODO set font to bold

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
  love.graphics.print(string.format("Width: %d, Height: %d\nMouse at %d, %d",
                                    winW, winH, love.mouse.getX(), love.mouse.getY()))
  local text = [[
              E - hold to erase
              F - cover window
              E+F - wipe window
              L - load from /assets
              S - save to]]..love.filesystem.getSaveDirectory()
  love.graphics.printf(text, 0, 0, winW, "right")
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
