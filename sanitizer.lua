---@param verbt string[]
---@param dverbt string[]
---@param verbs string[]
---@param defer integer
local function handle_verbs(verbt, dverbt, verbs, defer)
	local cnt = 1

	for _, verb in ipairs(verbs) do
		if defer and cnt >= defer then table.insert(dverbt, 1, verb)
		else table.insert(verbt, verb) end

		cnt = cnt + 1
	end
end

---@return run_entry sanitized
return function()
	---@type run_entry
	local res = {}
	---@type string[]
	local verbs, dverbs = {}, {}

	for _, depth in ipairs(RUNLIST) do
		for command, val in pairs(depth) do
			if command == "verbs" then
				handle_verbs(verbs, dverbs, depth.verbs, depth.defer)
			elseif command ~= "defer" then res[command] = val end
		end
	end

	for _, dverb in ipairs(dverbs) do
		table.insert(verbs, dverb)
	end

	res.verbs = verbs

	return res
end