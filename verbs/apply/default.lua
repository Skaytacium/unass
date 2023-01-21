---@param item string
---@param dir string?
---@param args string?
return function(item, dir, args)
	os.execute(("%s%s%s"):format(dir and ("cd %s; "):format(dir) or "", "~/test.sh", args and " " .. args or ""))
end