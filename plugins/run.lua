--
local util = require('awmni/util')
local awmni = require('awmni/main')
--


awmni:register('run', {
	test = function()
		log('hi')
	end
})
