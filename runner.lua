---@param item string
---@param runlist run_entry
---@return boolean?
return function(item, runlist)
	print(item)

	if runlist.branch and runlist.branch ~= OPTIONS.branch then return end
	if runlist.dir then
		---@type boolean | integer ? 
		local code = INODE_EXISTS(runlist.dir, true)

		if not code then _, _, code = os.execute("mkdir -p " .. runlist.dir) end
		if code ~= 0 then _, _, code = os.execute(OPTIONS.elevate .. " mkdir -p " .. runlist.dir) end
		if code ~= 0 then return false end
	end

	for _, verb in ipairs(runlist.verbs) do
		if not INODE_EXISTS(("./verbs/%s/%s.lua"):format(verb, item)) then
			if not INODE_EXISTS(("./verbs/%s/init.lua"):format(verb)) then return false

			else require(("verbs.%s"):format(verb))(item, runlist.dir, runlist.args) end
		else require(("verbs.%s.%s"):format(verb, item))(item, runlist.dir, runlist.args) end
	end

	print()
	return true
end