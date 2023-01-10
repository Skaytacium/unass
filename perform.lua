local function run(command, option)
	print()
	print(command)
	dump(option)
	return true
end

---@param items string[] items to perform
---@return boolean success if item was performed successfully
return function(items)
	for _, item in ipairs(items) do
		print(item)
		for _, runs in ipairs(RUNLIST) do for command, option in pairs(runs) do
			if not run(command, option) then return false end
		end end
		print "---"
	end

	return true
end