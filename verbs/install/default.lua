---@param item string
---@param dir string
---@param args string?
return function(item, dir, args)
	if not dir or dir == "" then
		P("1;31", "no directory to install " .. item .. " specified")
		return
	end
	if not INODE_EXISTS(dir .. "/" .. item) then
		P("1;31", item .. " does not exist at " .. dir)
		return
	end

	TRY_UNTIL({
		("cd %s; make install %s"):format(dir, args),
		"couldn't install " .. item .. " as user, elevating",
		"installed " .. item .. " as user"
	}, {
		("cd %s; %s make install %s"):format(dir, OPTIONS.elevate, args)
		"couldn't install " .. item .. " as root",
		"installed " .. item .. " as root"
	})
end