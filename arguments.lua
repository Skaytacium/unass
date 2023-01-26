---@type { branch: string, sync: boolean?, script: string? }
local res = {}
local parameter = nil

if #arg < 1 then
	P("31;1", "unass: requires atleast 1 argument (branch)")
	os.exit(1)
end

for i, a in ipairs(arg) do
	if parameter then
		res[parameter] = a
		parameter = nil
	elseif a == "-s" or a == "--sync" then
		res.sync = true
	elseif a == "-a" or a == "--apply" then
		res.sync = false
	elseif a == "-S" or a == "--script" then
		parameter = "script"
	elseif a:sub(1, 1) ~= "-" then
		res.branch = a
	end
end

if not res.branch then
	P("31;1", "no branch specified")
	os.exit(1)
end

return res