---@param item string
---@param dir string
---@param args string?
return function(item, dir, args)
	if not dir or dir == "" then
		P("1;31", "no directory to extract " .. item .. " specified")
		return
	end
	if not INODE_EXISTS(dir .. "/" .. item .. ".arc") then
		P("1;31", item .. ".arc does not exist at " .. dir)
		return
	end

	P("1;34", "extracting " .. item)

	local command = ""

	if os.execute(('test $(file -b --mime-type "%s.arc") = "application/zip"'):format(item)) ~= 0 then
		command = 'unzip "%s.arc" -d "%s"'
	else command = 'tar -xf "%s.arc" -C "%s"' end

	command = command:format(item)

	TRY_UNTIL({
		("cd %s; %s %s"):format(dir, command, args),
		"couldn't extract " .. item .. " as user, elevating",
		"extracted " .. item .. " as user"
	}, {
		("cd %s; %s %s %s"):format(dir, OPTIONS.elevate, command, args),
		"couldn't extract " .. item .. " as root",
		"extracted " .. item .. " as root"
	})
end