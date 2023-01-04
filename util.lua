---@param arr {[string]: function} table in which keys are compared
---@param cmp string value to compare keys to
---@return boolean
function IS_KEY(arr, cmp)
	for k in pairs(arr) do
		if k == cmp then return true end
	end

	return false
end

return { IS_KEY }
