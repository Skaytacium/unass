---@param items string[] items to perform
---@return boolean success if item was performed successfully
return function(items)
	for _, item in ipairs(items) do
		print(item)
		dump(RUNLIST)
		print()
	end

	return true
end