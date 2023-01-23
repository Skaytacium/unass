---@param item string
---@param dir string
---@param args string?
return function(item, dir, args)
	if not dir or dir == "" then
		P("1;31", "no directory to build " .. item .. " specified")
		return
	end
	if not INODE_EXISTS(dir .. "/" .. item, true) then
		P("1;31", item .. " does not exist at " .. dir)
		return
	end

	P("1;34", "building " .. item)

	TRY_UNTIL({
		("cd %s; make %s"):format(dir .. "/" .. item, args),
		"couldn't build " .. item .. " as user, elevating",
		"built " .. item .. " as user"
	}, {
		("cd %s; %s make %s"):format(dir .. "/" .. item, OPTIONS.elevate, args)
		"couldn't build" .. item .. " as root",
		"built " .. item .. " as root"
	})
end