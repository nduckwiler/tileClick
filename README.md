# tileClick

A simple utility app to build, save, and load tile maps

There are number of existing utilities for writing and editing tile maps. [Tiled](http://www.mapeditor.org/) is a stand-alone application for orthogonal, hexagonal, and isometric maps. It can do fancy things like pattern-matching, automatic terrain transitions, and image placement. [Simple Tiled Implementation](https://github.com/karai17/Simple-Tiled-Implementation), or STI, takes maps produced by Tiled and loads and renders them in LÖVE. You might see some mentions of [Advanced Tile Loader](https://github.com/Kadoba/Advanced-Tiled-Loader) online, but that package is no longer maintained.

Although these utilities are powerful and fun to use, they take some time to learn. tileClick is a much simpler tool for beginners.

## Example

For tileClick's most basic use, just run the library as a LÖVE application. Drag the tileClick folder containing `main.lua`, `tileClick.lua`, and the `assets` folder onto your LÖVE application bundle (Mac OS X), `love.exe` file (Windows), or use the command line (Linux): `love /home/path/to/gamedir/`. You'll find instructions on-screen. If you want to see how each of tileClick's functions are used, read through `main.lua`.

![on-screen](https://github.com/nduckwiler/tileClick/blob/master/assets/on-screen.png)

## API Reference

tileClick represents tile maps with strings, which might look like this:

```
[[
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
-------#####-------####---------
---------#---------#------------
---------#---------#------------
---------#---------#------------
---------#---------#------------
---------#---------#------------
---------#---------#------------
---------#---------#------------
---------#---------#------------
---------#---------####---------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
--------------------------------
]]
```

If you paste this into `/assets/map.lua` tileClick will interpret this string as a map of 24 x 32 tiles, where pound signs (#) represent tiles and dashes (-) represent blank spaces (in reality tileClick only cares whether the character is a # or anything else). The map will be rendered like this:

![TC-map](https://github.com/nduckwiler/tileClick/blob/master/assets/TC-map.png)

tileClick assumes that you are working with a 800 x 600 pixel LÖVE window and using 25 x 25 pixel tiles. Changing these settings using the GUI may be added as a feature later on, but for now this can be adjusted in the `main.lua` file.

## Requirements

This library recommends LÖVE 0.10.

## Installation

Copy `tileClick.lua` to your root folder and require it:

```lua
TC = require "tileClick"
```

Note that when you ask tileClick to load a map using `TC:loadMap()`, it assumes you have in the root directory an `assets` folder containing `map.lua`.

## License

tileClick is licensed under the MIT License.
