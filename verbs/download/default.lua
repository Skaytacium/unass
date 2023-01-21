---@param item string
---@param dir string?
---@param args string?
return function(item, dir, args)
	print("download default")
	print(item)
	print(dir)
	print(args)
end

-- curl -fL "$2" -o "$1.arc"