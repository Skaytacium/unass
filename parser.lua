local prev_depth = 0

---@param tokens string[][]
---@param depth integer
---@return string[] | nil
return function(tokens, depth)
	---@type string[]
	local items = {}
	depth = depth + 1

	if depth < prev_depth then
		local i = prev_depth
		while i > depth do
			i = i - 1
			RUNLIST[i] = nil
		end
	end

	if not RUNLIST[depth] then RUNLIST[depth] = {} end

	for _, list in ipairs(tokens) do
		if COMMANDS[list[1]] then
			local command = table.remove(list, 1)

			local set = COMMANDS[command].callback(list)

			if not set then return end
			RUNLIST[depth][command] = set
		elseif list[1] == "item" then
			table.insert(items, list[2])
		elseif list[1] == "verb" then
			if not RUNLIST[depth].verbs then RUNLIST[depth].verbs = {} end
			table.insert(RUNLIST[depth].verbs, list[2])
		elseif list[1] == "defer" then
			if RUNLIST[depth].verbs then RUNLIST[depth].defer = #RUNLIST[depth].verbs + 1
			else RUNLIST[depth].defer = 1 end
		end
	end

	prev_depth = depth

	return items
end