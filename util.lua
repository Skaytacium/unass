---@param tab table table to compare in
---@param cmp string value to compare to
---@param key boolean? check if it is present as a key
---@return boolean
function IN_TABLE(tab, cmp, key)
	if key then
		for k in pairs(tab) do
			if k == cmp then return true end
		end
	else
		for _, v in ipairs(tab) do
			if v == cmp then return true end
		end
	end

	return false
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

---@param table table<any, any>
---@return integer
function DICT_LENGTH(table)
	if not table then return 0 end

	local count = 0
	for _ in pairs(table) do
		count = count + 1
	end

	return count
end