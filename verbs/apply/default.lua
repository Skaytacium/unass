---@param inode string
---@param branch string
local function apply(inode, branch)
	local filetype = io.popen(("cd %s; git cat-file -t %s:%s"):format(OPTIONS.store, branch, inode)):read()

	if filetype == "tree" then
		print("1")
		print(io.popen(("cd %s; git ls-tree %s:%s"):format(OPTIONS.store, branch, inode)))
	elseif filetype == "blob" then
		print("2")
		print(io.popen(("cd %s; git cat-file -p %s:%s"):format(OPTIONS.store, branch, inode)))
	else return end
end

---@param inode string
---@param branch string?
return function(inode, branch)
	branch = branch and branch or OPTIONS.branch

	local default_branch = GET_DEFAULT_BRANCH()

	print(inode)
	print(branch)

	apply(inode, default_branch)
	apply(inode, branch)
end