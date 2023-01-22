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

---@param value any
---@param depth string?
function DUMP(value, depth)
	depth = depth and depth or ""

	if type(value) ~= "table" then
		print(value .. "\t not a table")
	else
		print(depth .. "{")
		for k, v in pairs(value) do
			if type(v) == "table" then DUMP(v, depth .. "\t")
			else print(("%s%s: %s"):format(depth .. "\t", k, v)) end
		end
		print(depth .. "}")
	end
end

---@param ... string[]
---@return integer[]
function TRY_UNTIL(...)
	---@type integer[]
	local codes = {}

	for i, try in ipairs({...}) do
		if not try[1] then error("no command to execute specified") end

		table.insert(codes, i, os.execute(try[1]))

		if codes[i] ~= 0 then
			if try[2] then P(({...})[i + 1] and "1;33" or "1;31", try[2]) end
		else
			if try[3] then P("1;32", try[3]) end
			return codes
		end
	end

	return codes
end