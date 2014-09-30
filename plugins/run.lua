--
local util = require('awmni/util')
local awmni = require('awmni/main')
--


awmni:register('run', function()
	local cmd = 'rofi -show run'
	return util.run(cmd)
end)
