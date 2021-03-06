--
-- TODO: this is duplicated from my dotfiles, needs to be broken out
local _ = require("awmni/_")
-- TODO: figure out requiring with relative paths
local util = require('awmni/util')
--


local function menuFactory(...)
	local menu = {
		name = 'awmni',
		actions = {},
		-- handler = function() end
	}

	local args = {...}
	for a,arg in ipairs(args) do
		local argType = type(arg)

		if argType == 'string' then
			menu.name = arg
		elseif argType == 'table' then
			menu.actions = arg
		elseif argType == 'function' then
			menu.handler = arg
		end
	end

	-- give extra methods to menus
		menu.register = function(self, ...)
			local plugin = menuFactory(...)

			if plugin.name ~= 'awmni' then
				self.actions[plugin.name] = plugin
			end

			return plugin
		end

		menu.open = function(self)
			local choices = _.keys(self.actions)
			awmni.prompt(choices, function(choice)
				local action = self.actions[choice]

				if type(action) == 'table' then
					if action.handler then
						action.handler()
					else
						action:open()
					end
				elseif type(action) == 'function' then
					action()
				end
			end)
		end

	return menu
end


awmni = menuFactory()

-- TODO: allow options to be passed
awmni.prompt = function(prompt, choices, fn)
	if not fn then
		fn = choices
		choices = prompt
		prompt = '>'
	end

	local choice = util.exec('echo -e "' .. table.concat(choices, '\n') .. '"' .. ' | ' .. 'rofi -dmenu -p "' .. prompt .. '"')

	if type(fn) ~= 'function' then return choice end
	return fn(choice)
end

-- TODO: allow options to be passed
-- TODO: make this an action defined on the main awmni menu (it's just here for legacy purposes)
awmni.launcher = function()
	local cmd = 'rofi -show run'
	return util.run(cmd)
end

-- expose utilities
awmni.util = util


return awmni
