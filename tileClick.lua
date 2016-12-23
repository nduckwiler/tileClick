--[[
tileClick.lua
VERSION: 1.0
TODO
view HUD and pop-up menu for saving?
adjust map size
adjust tile size
each call returns a new instance with a new color so that user may build multiple maps
]]

local loveRead, tostring, assert, error, drawRect, ceil, floor, winW, winH =
  love.filesystem.read, tostring, assert, error,
   love.graphics.rectangle, math.ceil, math.floor, love.graphics.getWidth(), love.graphics.getHeight()

local modname = ...       --require(...) passes the file name to the module
local M = {}              --table M will hold the module functions
_G[modname] = M           --add the table to the set of global vars
package.loaded[modname] = M  --this makes require(...) return M
setfenv(1,M)

local TILEW, TILEH, tilesAcross, tilesDown, tileTable, mode, modes
modes = {["draw"] = true, ["erase"] = true}
mode = "draw"
TILEW, TILEH = 25, 25
tilesAcross, tilesDown = ceil(winW/TILEW), ceil(winH/TILEH)
tileTable = {}
for col = 1,tilesAcross do
  tileTable[col] = {}
  for row = 1,tilesDown do
    tileTable[col][row] = false
  end
end

function setMode(self, str)
  if not modes[str] then error("Requested mode "..str.."does not exist.") end
  self.mode = str
end

function fill(self, x, y)
  local col,row
  row = floor(y / TILEH) + 1 -- to avoid indexing 0
  col = floor(x / TILEW) + 1

  if self.mode == "draw" then tileTable[col][row] = true
  elseif self.mode == "erase" then tileTable[col][row] = false
  end
end

-- based on loadMap in map_functions.lua
function loadMap(self, path)
  local tileString = loveRead(path)
  newMap(self, tileString)
end

-- based on newMap in map_functions.lua
-- writes new data to tileTable as defined by tileString
function newMap(self, tileString)
  local width = #(tileString:match("[^\n]+")) --get width of first line

  for x = 1,width,1 do tileTable[x] = {} end --fill tileTable with columns

  local rowIndex,columnIndex = 1,1
  for row in tileString:gmatch("[^\n]+") do
    assert(#row == width, 'tileString is not aligned: width of row '..tostring(rowIndex)..' is '..tostring(#row)..' but it should be '..tostring(width))
    columnIndex = 1
    for character in row:gmatch(".") do
      if character == "#" then tileTable[columnIndex][rowIndex] = true
      else tileTable[columnIndex][rowIndex] = false
      end
      columnIndex = columnIndex + 1
    end
    rowIndex = rowIndex + 1
  end
  return tileTable
end

-- Uses love.graphics.rectangle to draw current tileTable
function draw(self)
  for col = 1,#tileTable do
    for row = 1,#tileTable[col] do
      if tileTable[col][row] then
        drawRect("fill", (col - 1) * TILEW, (row - 1) * TILEH, TILEW, TILEH)
      end
    end
  end
end

-- Covers window with tiles if mode is "draw". Otherwise, erases all tiles
function cover(self)
  local entry = (self.mode == "draw")
  for col = 1,#tileTable do
    for row = 1,#tileTable[col] do
      tileTable[col][row] = entry
    end
  end
end

function printStr(self)
  local str,line = "", ""

  for row = 1,tilesDown do
    line = ""
    for col = 1,tilesAcross do
      if tileTable[col][row] then
        line = line.."#"
      else
        line = line.."-"
      end
    end
    line = line.."\n"
    str = str..line
  end
  return str
end
