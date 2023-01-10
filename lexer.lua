---@param line string line to parse
---@return string[][] | nil, integer | nil
return function(line)
	if #line == 0 then return end

	-- Syntax is rigid, so this will always be in the beginning
	local line, depth = line:gsub("\t", "")
	---@type string[][]
	local commands, command = {}, {}
	---@type string | integer
	local state = 0

	for word, line_pos in line:gmatch("(%g+)()") do
		if word == "#" or word:sub(1, 1) == "#" then return end

		if COMMANDS[word] then
			if state == 0 then state = COMMANDS[word].state end
			if state == 0 then
				table.insert(commands, { word, line:sub(line_pos + 1) })
				break
			end
		end

		if word == "\"" then
			if state < 0 then state = 0
			else state = -1 end
		end

		if state ~= 0 then
			-- Another check to not add apostrophe as input
			if state ~= -1 then table.insert(command, word) end
			state = state - 1
		end

		if state == 0 then
			if #command == 0 then
				if IN_TABLE(VERBS, word .. "/") then command = { "verb", word }
				elseif word == "defer" then command = { "defer" }
				else command = { "item", word } end
			end
			table.insert(commands, command)
			command = {}
		end
	end

	return commands, depth
end