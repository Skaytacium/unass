---@param file string
---@param branch string
local function cp(file, branch)
	return FIND_IN_TABLE(TRY_UNTIL({
		("cd %s; git cat-file -p %s:%s > /%s")
		:format(OPTIONS.store, branch, file, file),
		("couldn't apply %s as user, elevating"):format(file),
		("applied %s as user"):format(file)
	}, {
		("cd %s; git cat-file -p %s:%s | %s tee /%s")
		:format(OPTIONS.store, branch, file, OPTIONS.elevate, file),
		("couldn't apply %s as root"):format(file),
		("applied %s as root"):format(file)
	}), 0)
end

---@param inode string
---@param branch string
local function apply(inode, branch)
	local filetype = io.popen(("cd %s; git cat-file -t %s:%s 2>/dev/null"):format(OPTIONS.store, branch, inode)):read()

	if filetype == "tree" then
		local files = io.popen(("cd %s; git ls-tree -r --name-only %s:%s"):format(OPTIONS.store, branch, inode))
		---@diagnostic disable-next-line: need-check-nil
		local file = files:read()

		repeat
			cp(inode .. "/" .. file, branch)

			---@diagnostic disable-next-line: need-check-nil
			file = files:read()
		until not file
	elseif filetype == "blob" then cp(inode, branch)
	else return end
end

---@param inode string
---@param branch string?
return function(inode, branch)
	branch = branch and branch or OPTIONS.branch

	apply(inode, GET_DEFAULT_BRANCH())
	apply(inode, branch)
end