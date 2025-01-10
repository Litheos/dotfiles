--#!usr/bin/env lua
-- Change Wallpaper

-- swww parameters
local fps = 60
local type = "any"
local duration = 1
local resize = "fit"
local flags = " --transition-fps "
	.. fps
	.. " --transition-type "
	.. type
	.. " --transition-duration "
	.. duration
	.. " --resize "
	.. resize

-- Ensure swww daemon is running
local function checkSww()
	local result = os.execute("query swww")
	if result == "" then
		os.execute("uwsm app -- swww-daemon --format xrgb")
	end
end

function ChangeWallpaper(wallpaper)
	checkSww()
	local exit_code = os.execute("uwsm app -- swww img " .. wallpaper .. flags)
	if exit_code ~= 0 then
		print("Command failed with exit code: " .. exit_code)
	else
		-- run wallust
		local result = os.execute("uwsm app -- wallust run " .. wallpaper)
		if result ~= 0 then
			print("Command failed with exit code: " .. result)
		else
			--todo: stop and start other processes
		end
	end
end
