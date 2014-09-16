--
local awful = require("awful")
--


local util = {}


util.run = awful.util.spawn
util.shell = awful.util.spawn_with_shell
util.pread = awful.util.pread

util.exec = function(cmd)
	result = util.pread(cmd)
	if result:sub(-1) == "\n" then result = result:sub(1, -2) end
	return result
end


return util
