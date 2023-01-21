---@param item string
---@param dir string?
---@param args string?
return function(item, dir, args)
	print("extract default")
	print(item)
	print(dir)
	print(args)
end

-- mkdir "$1"
-- if [ $(file -b --mime-type "$1.arc") = "application/zip" ]; then
-- 	unzip "$1.arc" -d "$1"
-- else
-- 	tar -xf "$1.arc" -C "$1"
-- fi
