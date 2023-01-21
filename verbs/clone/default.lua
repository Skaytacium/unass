---@param item string
---@param dir string?
---@param args string?
return function(item, dir, args)
	print("clone default")
	print(item)
	print(dir)
	print(args)
end

-- if [ -d "$1" ]; then
-- 	cd "$1"
-- 	git pull && git submodule update --recursive
-- else
-- 	git clone "$2" "$1"
-- fi