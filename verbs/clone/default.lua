local function get_remote(repo)
	local remote = "https://%s.com/" .. repo

	local codes = #TRY_UNTIL({
		"curl -fL https://github.com/" .. repo .. " >/dev/null 2>&1",
		repo .. " not available on GitHub, trying GitLab",
		"using GitHub for " .. repo
	}, {
		"curl -fL https://gitlab.com/" .. repo .. " >/dev/null 2>&1",
		repo .. " not available on GitLab",
		"using GitLab for " .. repo
	})

	if codes == 1 then return remote:format("github")
	elseif codes == 2 then return remote:format("gitlab")
	else return nil end
end

---@param repo string
---@param dir string
---@param args string?
return function(repo, dir, args)
	if not repo or repo == "" then
		P("31;1", "no repository to clone/update specified")
		return
	end
	if not dir or dir == "" then
		P("31;1", "no directory to clone " .. repo .. " in specified")
		return
	end

	local nameish = repo:match("[^/]+$")

	if INODE_EXISTS(dir .. "/" .. nameish, true) then
		P("1;34", "updating " .. repo)

		TRY_UNTIL({
			("cd %s; git pull && git submodule update --recursive"):format(dir .. "/" .. nameish),
			"couldn't pull changed and/or update submodules for " .. repo,
			"pulled changes and updated submodules for " .. repo
		})
	else
		P("1;34", "cloning " .. repo)

		local remote = get_remote(repo)

		if not remote then
			P("31;1", "remote for " .. repo .. " is not GitHub or GitLab")
			return
		end

		if not INODE_EXISTS(dir, true) then CREATE_DIR_OR_FAIL(dir) end

		TRY_UNTIL({
			("cd %s; git clone %s %s"):format(dir, remote, args),
			"couldn't clone " .. repo .. " as user, elevating",
			"cloned " .. repo .. " as user"
		}, {
			("cd %s; %s git clone %s %s"):format(dir, OPTIONS.elevate, remote, args),
			"couldn't clone " .. repo .. " as root",
			"cloned " .. repo .. " as root"
		})
	end
end