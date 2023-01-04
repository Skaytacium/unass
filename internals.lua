return {
	---@param args string
	["set"] = function(args)
		---@type string[]
		local temp = {}

		for word in args:gmatch("%g+") do
			table.insert(temp, word)
		end

		OPTIONS[temp[1]] = temp[2]

		return true
	end,
	---@param cmd string
	["shell"] = function(cmd)
		print("run in shell " .. cmd)
		return true
	end,
	["defer"] = function()
		print "defer"
	end,
}