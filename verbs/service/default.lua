---@param item string
return function(item)
	if not INODE_EXISTS("/etc/sv/" .. item, true) then
		P("31;1", "service " .. item .. " does not exist")
		return
	end

	P("1;34", "servicing " .. item)

	return FIND_IN_TABLE(TRY_UNTIL({
		('ln -sf "/etc/sv/%s" "/var/service"'):format(item),
		"couldn't service " .. item .. " as user, elevating",
		"serviced " .. item .. " as user"
	}, {
		('%s ln -sf "/etc/sv/%s" "/var/service"'):format(OPTIONS.elevate, item)
		"couldn't service " .. item,
		"serviced " .. item .. " as root"
	}), 0)
end