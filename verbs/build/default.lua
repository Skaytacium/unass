---@param item string
---@param dir string?
---@param args string?
return function(item, dir, args)
	print("build default")
	print(item)
	print(dir)
	print(args)
end

-- cd "$1"
-- make