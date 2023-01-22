---@param item string
---@param runlist run_entry
---@return boolean?
return function(item, runlist)
	if runlist.branch and runlist.branch ~= OPTIONS.branch then return end
	if runlist.dir then
		---@type boolean | integer ? 
		local code = INODE_EXISTS(runlist.dir, true)

		if not code then
			code = os.execute("mkdir -p " .. runlist.dir)
			if code ~= 0 then code = os.execute(OPTIONS.elevate .. " mkdir -p " .. runlist.dir) end
			if code ~= 0 then error("couldn't create " .. runlist.dir) end
		end
	end

	for _, verb in ipairs(runlist.verbs) do
		if not INODE_EXISTS(("verbs/%s/%s.lua"):format(verb, item)) then
			if not INODE_EXISTS(("verbs/%s/default.lua"):format(verb)) then return false

			else require(("verbs.%s.default"):format(verb))(item, runlist.dir, runlist.args) end
		else require(("verbs.%s.%s"):format(verb, item))(item, runlist.dir, runlist.args) end
	end

	return true
end