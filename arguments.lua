---@type { branch: string, sync: boolean?, location: string? }
local res = {}
local parameter = nil

if #arg < 1 then
	P("31;1", "unass: requires atleast 1 argument (branch)")
	P("33;1", "Try 'luajit unass.lua --help'")
	os.exit(1)
end

for _, a in ipairs(arg) do
	if parameter then
		res[parameter] = a
		parameter = nil
	elseif a == "-h" or a == "--help" then
		print("Usage: unass [options] branch\n")
		print([[Options:
	-h, --help		  Display this help message
	-s, --sync		  Sync from system to store and exit
	-a, --apply		  Apply from store to system and exit
	-d, --location DIRECTORY  Directory where script.unass and definitions.unass are]])
		os.exit(0)
	elseif a == "-s" or a == "--sync" then
		res.sync = true
	elseif a == "-a" or a == "--apply" then
		res.sync = false
	elseif a == "-d" or a == "--location" then
		parameter = "location"
	elseif a:sub(1, 1) ~= "-" then
		res.branch = a
	end
end

if not res.branch then
	P("31;1", "no branch specified")
	os.exit(1)
end

return res