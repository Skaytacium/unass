---@generic P, Q
---@param tab table<Q, P>
---@param val P | Q
---@param key boolean?
---@return P | Q
function FIND_IN_TABLE(tab, val, key)
	for k, v in pairs(tab) do
		if key and k == val then return v
		elseif v == val then return k end
	end

	return nil
end

---@param dir string path to directory
---@param params string? parameters to pass to `ls`. E.g. `-a` will show hidden files
---@return string[] files list of files
function READ_DIR(dir, params)
	local temp = {}
	-- Don't substitute as literally 'nil'
	if not params then params = "" end

	local output = io.popen(string.format("ls -p%s %s", params, dir))
	local file = nil

	repeat
		table.insert(temp, file)
		---@diagnostic disable-next-line: need-check-nil
		file = output:read()
	until not file

	return temp
end

---@param path string
---@param dir? boolean
---@return boolean exists
function INODE_EXISTS(path, dir)
	return os.execute("test " .. (dir and "-d " or " -f ") .. path) == 0
end