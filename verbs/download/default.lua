---@param item string
---@param dir string
---@param link string
return function(item, dir, link)
	if not dir then
		P("1;31", "no directory to download " .. item .. " specified")
		return
	end
	if not link then
		P("1;31", "no link to download " .. item .. " specified")
		return
	end
	if not INODE_EXISTS(dir, true) then CREATE_DIR_OR_FAIL(dir) end

	P("34;1", "downloading " .. item)

	return FIND_IN_TABLE(TRY_UNTIL({
		('cd %s; curl -fL "%s" -o "%s.arc"'):format(dir, link, item),
		"couldn't download in " .. dir .. " as user, elevating",
		"downloaded " .. item ..  " as user"
	}, {
		('cd %s; %s curl -fL "%s" -o "%s.arc"'):format(dir, OPTIONS.elevate, link, item),
		"couldn't download " .. item,
		"downloaded " .. item ..  " as root"
	}), 0)
end