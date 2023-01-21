---@param item string
return function(item)
	if not INODE_EXISTS("/etc/sv/" .. item, true) then
		P("31;1", "service " .. item .. " does not exist")
		return
	end

	P("34;1", "servicing " .. item)
	if os.execute(('ln -sf "/etc/sv/%s" "/var/service"'):format(item)) ~= 0 then
		P("32;1", "using root to service " .. item)
		os.execute((OPTIONS.elevate .. ' ln -sf "/etc/sv/%s" "/var/service"'):format(item))
	end

	P("34;1", "serviced " .. item)
end