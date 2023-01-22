---@param item string
---@param dir string?
---@param args string?
return function(item, dir, args)
	if not dir or dir == "" then
		P("1;31", "no directory to install " .. item .. " specified")
		return
	end
	if not INODE_EXISTS(dir .. "/" .. item) then
		P("1;31", item .. " does not exist at " .. dir)
		return
	end

	P("1;34", "installing " .. item .. " from source")

	TRY_UNTIL(
		{
			("cd %s; ")
		}
	)
end

-- mkdir "$1"
-- if [ $(file -b --mime-type "$1.arc") = "application/zip" ]; then
-- 	unzip "$1.arc" -d "$1"
-- else
-- 	tar -xf "$1.arc" -C "$1"
-- fi
